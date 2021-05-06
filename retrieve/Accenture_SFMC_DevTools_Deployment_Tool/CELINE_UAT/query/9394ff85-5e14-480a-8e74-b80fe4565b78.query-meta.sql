SELECT
    sfdc.Id,
    sfdc.PersonContactId AS ContactKey,
    CASE
        WHEN sfdc.cel_PersonEmail__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNSUBS_OUTSIDE_CLOUD_PAGE_HISTORY_DE
            WHERE
                [Date Of Unsubscription] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        ) THEN 1
        ELSE 0
    END AS FirstEmailCheck,
    CASE
        WHEN sfdc.cel_email_2__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNSUBS_OUTSIDE_CLOUD_PAGE_HISTORY_DE
            WHERE
                [Date Of Unsubscription] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        ) THEN 1
        ELSE 0
    END AS SecondEmailCheck,
    unsubs.[Date Of Unsubscription] AS 'Date Of Unsubscription'
FROM
    ENT.Account_Salesforce AS sfdc
    JOIN UNSUBS_OUTSIDE_CLOUD_PAGE_HISTORY_DE AS unsubs ON sfdc.PersonContactId = unsubs.ContactKey
WHERE
    unsubs.[Date Of Unsubscription] >= DateAdd(DAY, -1, cast(GetDate() AS date))
    AND (
        cel_PersonEmail__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNSUBS_OUTSIDE_CLOUD_PAGE_HISTORY_DE
            WHERE
                [Date Of Unsubscription] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        )
        OR cel_email_2__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNSUBS_OUTSIDE_CLOUD_PAGE_HISTORY_DE
            WHERE
                [Date Of Unsubscription] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        )
    )