SELECT
    subs.ContactKey AS ContactKey,
    CASE
        WHEN (
            sfdc.PersonEmail IS NULL
            AND subs.Status = 'Active'
        ) THEN 'unsubscribed'
        WHEN (
            sfdc.PersonEmail != subs.Email
            AND subs.Status = 'Active'
        ) THEN 'active'
        WHEN (
            subs.Status = 'unsub'
            OR subs.Status = 'Undeliverable'
        )
        AND sfdc.PersonEmail IS NOT NULL THEN 'active'
    END AS STATUS,
    CASE
        WHEN (
            sfdc.PersonEmail IS NULL
            AND subs.Status = 'active'
        ) THEN subs.Email
        WHEN (
            sfdc.PersonEmail != subs.Email
            AND subs.Status = 'active'
        ) THEN sfdc.PersonEmail
        WHEN (
            subs.Status = 'unsub'
            OR subs.Status = 'Undeliverable'
        )
        AND sfdc.PersonEmail IS NOT NULL THEN sfdc.PersonEmail
    END AS Email,
    subs.Status AS 'Old Status',
    subs.Email AS 'Old Email',
    CONVERT(date, GETDATE()) AS 'Date Of The Update'
FROM
    ENT.Account_Salesforce AS sfdc
    INNER JOIN SUBSCRIBERS_STATUS_DE AS subs ON sfdc.PersonContactId = subs.ContactKey
WHERE
    (
        (
            sfdc.PersonEmail IS NULL
            AND subs.Status = 'Active'
        )
        OR (
            sfdc.PersonEmail != subs.Email
            AND subs.Status = 'Active'
        )
        OR (
            (
                subs.Status = 'unsub'
                OR subs.Status = 'Undeliverable'
            )
            AND sfdc.PersonEmail IS NOT NULL
        )
    )
    AND sfdc.RecordTypeId = '0121r0000007NppAAE'