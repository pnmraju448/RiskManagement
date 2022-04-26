namespace riskmanagement;

using {managed} from '@sap/cds/common';

entity Risks :  managed {
   key ID    : UUID @(Core.Computed : true);
   title     : String(100);
   owner     : String;
   prio      : String(5);
   descr     : String;
   miti      : Association to Mitigations;
   impact    : Integer;
   bp        : Association to BusinessPartners;
   criticality : Integer;
}

entity Mitigations : managed {
    Key ID       : UUID @(Core.Computed : true);
        descr    : String;
        owner    : String;
        timeline : String;
        risks    : Association to many Risks on risks.miti = $self;
}
// Using an external service from S/4
using { API_BUSINESS_PARTNER as external } from '../srv/external/API_BUSINESS_PARTNER.csn';

entity BusinessPartners as projection on external.A_BusinessPartner {
   Key BusinessPartner,
        LastName,
        FirstName 
}