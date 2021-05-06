SELECT
    sfdc.Id,
    sfdc.PersonContactId AS ContactKey,
    CASE
        WHEN sfdc.cel_PersonEmail__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNDELIVERABLE_STATUS_HISTORY_DE
            WHERE
                [Date Held] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        ) THEN 1
        ELSE 0
    END AS FirstEmailCheck,
    CASE
        WHEN sfdc.cel_email_2__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNDELIVERABLE_STATUS_HISTORY_DE
            WHERE
                [Date Held] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        ) THEN 1
        ELSE 0
    END AS SecondEmailCheck,
    heldStatus.[Date Held] AS 'Date Held'
FROM
    ENT.Account_Salesforce AS sfdc
    JOIN UNDELIVERABLE_STATUS_HISTORY_DE AS heldStatus ON sfdc.PersonContactId = heldStatus.ContactKey
WHERE
    heldStatus.[Date Held] >= DateAdd(DAY, -1, cast(GetDate() AS date))
    AND (
        sfdc.cel_PersonEmail__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNDELIVERABLE_STATUS_HISTORY_DE
            WHERE
                [Date Held] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        )
        OR sfdc.cel_email_2__c IN (
            SELECT
                DISTINCT Email
            FROM
                UNDELIVERABLE_STATUS_HISTORY_DE
            WHERE
                [Date Held] >= DateAdd(DAY, -1, cast(GetDate() AS date))
        )
    )