public without Sharing class ReOpenCaseWithCustomerResponse {
    
    public static void updateStatusOnIncomingEmail(List<EmailMessage> list_emailMessages){
        Map<Id, EmailMessage> emIds = new Map<Id, EmailMessage>();
        List<Case> casetoUpdate = new List<Case>();
        for (EmailMessage em : list_emailMessages){
            if(em.Incoming){
                emIds.put(em.ParentId, em);
            }
        }
        if(emIds.size()>0){
            List<Case> caseList = [Select id,Status from Case Where Id IN : emIds.keySet() AND Status != 'Closed' AND Status != 'New'];
            if(caseList.size()>0){
                for(Case c : caseList){
                    c.Status = 'Open'; 
                    casetoUpdate.add(c);
                }
                if(casetoUpdate.size()>0){
                    update casetoUpdate;
                }
            }
        }
    }
}