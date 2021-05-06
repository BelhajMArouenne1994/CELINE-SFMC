SELECT
    PersonContactId AS Id,
    Id AS PersonAccountId,
    Salutation,
    FirstName,
    LastName,
    PersonEmail,
    cel_written_language__c,
    cel_customer_main_store__c,
    cel_do_not_email__c,
    PersonHasOptedOutOfEmail,
    cel_sent_by_sfcm__c,
    PersonBirthdate AT TIME ZONE 'Central America Standard Time' AT TIME ZONE 'GMT Standard Time' AS PersonBirthdate,
    cel_creation_date__c AT TIME ZONE 'Central America Standard Time' AT TIME ZONE 'GMT Standard Time' AS cel_creation_date__c,
    PersonEmailBouncedDate AT TIME ZONE 'Central America Standard Time' AT TIME ZONE 'GMT Standard Time' AS PersonEmailBouncedDate,
    cel_Last_Contact_Date__c AT TIME ZONE 'Central America Standard Time' AT TIME ZONE 'GMT Standard Time' AS cel_Last_Contact_Date__c,
    cel_age_range__c,
    cel_customer_emails_open_rate__c
FROM
    ENT.ACCOUNT_SALESFORCE
WHERE
    RecordTypeId = '0121r0000007NppAAE'
    AND (
        PersonContactId = '0033N00000Vr5gIQAR'
        OR PersonContactId = '0033N00000UzuxtQAB'
    )