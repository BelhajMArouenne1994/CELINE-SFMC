SELECT
    subs.SubscriberKey AS ContactKey,
    subs.EmailAddress AS Email,
    unsubs.UnsubDateUTC AS 'Date Of Unsubscription',
    unsubs.UnsubReason AS 'Reason Of Unsubscription'
FROM
    ENT.Account_Salesforce AS sfdc
    INNER JOIN ENT._Subscribers AS subs ON sfdc.PersonContactId = subs.SubscriberKey
    LEFT OUTER JOIN ENT._BusinessUnitUnsubscribes AS unsubs ON unsubs.SubscriberKey = subs.SubscriberKey
WHERE
    unsubs.UnsubReason != 'Unsubscribed FROM UAT Business Unit using Unsubscription Link'
    AND (
        unsubs.SubscriberKey = sfdc.PersonContactId
        AND unsubs.BusinessUnitID = '510003815'
    )
    AND sfdc.RecordTypeId = '0121r0000007NppAAE'