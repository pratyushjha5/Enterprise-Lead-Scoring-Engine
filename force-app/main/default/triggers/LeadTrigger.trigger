trigger LeadTrigger on Lead (before insert, before update) {
    // Enterprise Pattern: Delegate all logic to the Handler class
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            LeadTriggerHandler.handleBeforeInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            LeadTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}