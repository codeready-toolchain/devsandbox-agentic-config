# JIRA story guidelines
Guidelines for taking a design document, planning document or task document and translating them into a set of JIRA stories.

## Files
- Each JIRA story should be put into a separate markdown file eg. vm-creation-validation-webhook.md
- Put all jira story documents into a `jira` folder within the current workspace

## JIRA story fields and descriptions

**Title**
- JIRA title

**Description**
- Short description of the purpose of the story

**Acceptance Criteria**
- List of bullet points

**Completion Steps**
- List of bullet points
- High level tasks to complete the story

**Story Points**
- Use fibonacci numbers to set story points as an estimation of the complexity of the implementation. eg. 1,2,3,5,8,13,21
- 1 is the lowest complexity
- 21 is the highest complexity

## Example vm-creation-validation-webhook.md

Title: Block Creation of VMs Without Username Setup

Description: Most of our tools require the VM to have a user name configured in the cloud init configuration of the VM yaml. The VM validation webhook can be used to require the user name to be configured. The vast majority of VMs have it configured so it shouldn't cause too much friction in the VM trial experience.

Acceptance Criteria:
- It should block creation of VMs without username
- It should provide a user-friendly message

Completion Steps:
- Add logic to existing VM validation webhook

Story Points: 2