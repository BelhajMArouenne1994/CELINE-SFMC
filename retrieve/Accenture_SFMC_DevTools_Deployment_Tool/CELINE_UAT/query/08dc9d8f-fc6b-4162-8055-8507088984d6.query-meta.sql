SELECT
    subs.SubscriberKey AS ContactKey,
    sfdc.PersonEmail AS Email,
    CONVERT(date, GETDATE()) AS 'Date Of Resubscription',
    unsubs.UnsubDateUTC AS 'Date Of Unsubscription',
    unsubs.UnsubReason AS 'Reason Of Unsubscription'
FROM
    ENT.Account_Salesforce AS sfdc
    INNER JOIN ENT._Subscribers AS subs ON sfdc.PersonContactId = subs.SubscriberKey
    LEFT OUTER JOIN ENT._BusinessUnitUnsubscribes AS unsubs ON unsubs.SubscriberKey = subs.SubscriberKey
WHERE
    sfdc.PersonEmail IS NOT NULL
    AND (
        unsubs.SubscriberKey = sfdc.PersonContactId
        AND unsubs.BusinessUnitID = '510003815'
    )
    AND sfdc.RecordTypeId = '0121r0000007NppAAE'