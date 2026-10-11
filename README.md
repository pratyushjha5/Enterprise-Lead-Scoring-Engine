# Enterprise Lead Scoring & Routing Engine

## Overview
An automated lead qualification and routing system built on the Salesforce platform. This project replaces manual lead sorting by dynamically calculating engagement scores and surfacing high-value prospects to Sales Representatives through a custom Lightning Web Component (LWC) dashboard.

## Features
* **Automated Lead Scoring:** An Apex Trigger evaluates incoming Leads based on Industry, Annual Revenue, and Job Title to calculate a dynamic score.
* **Intelligent Routing:** Leads scoring 80+ points are automatically flagged with a "Hot" rating.
* **Actionable LWC Dashboard:** A custom Lightning Datatable surfaces untouched Hot leads directly on the Sales Home Page.
* **One-Click Updates:** Reps can mark leads as "Contacted" directly from the dashboard, executing an imperative Apex call to update the database and instantly refresh the UI.

## Technical Architecture
* **Frontend:** Lightning Web Components (LWC), JavaScript (ES6+), SLDS
* **Backend:** Apex Triggers, Apex Service Classes, SOQL
* **Security:** Enforced Object and Field-Level Security (`WITH SECURITY_ENFORCED`)
* **Deployment:** Salesforce CLI (SFDX), VS Code, Git

## Dashboard Preview
![Lead Scoring Dashboard](Screenshot%202026-10-12%20021557.png)
