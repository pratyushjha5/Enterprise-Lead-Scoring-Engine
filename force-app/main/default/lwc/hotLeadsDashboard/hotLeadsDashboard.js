import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getHotLeads from '@salesforce/apex/LeadScoringService.getHotLeads';
import updateLeadStatus from '@salesforce/apex/LeadScoringService.updateLeadStatus';

const ACTIONS = [
    { label: 'Mark as Contacted', name: 'mark_contacted' }
];

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Company', fieldName: 'Company', type: 'text' },
    { label: 'Title', fieldName: 'Title', type: 'text' },
    { label: 'Rating', fieldName: 'Rating', type: 'text', cellAttributes: { class: 'slds-text-color_success' } },
    {
        type: 'action',
        typeAttributes: { rowActions: ACTIONS },
    },
];

export default class HotLeadsDashboard extends LightningElement {
    columns = COLUMNS;
    leadsData = [];
    error;

    // This runs automatically when the component is placed on the screen
    connectedCallback() {
        this.fetchLeads();
    }

    // Bulletproof imperative Apex call
    fetchLeads() {
        getHotLeads()
            .then(result => {
                this.leadsData = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.leadsData = [];
                console.error('Error fetching leads:', error);
            });
    }

    async handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'mark_contacted') {
            try {
                await updateLeadStatus({ leadId: row.Id, newStatus: 'Working - Contacted' });
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: `Lead ${row.Name} updated successfully.`,
                        variant: 'success'
                    })
                );
                // Manually refresh the data after update
                this.fetchLeads();
            } catch (error) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating lead',
                        message: error.body ? error.body.message : error.message,
                        variant: 'error'
                    })
                );
            }
        }
    }
}