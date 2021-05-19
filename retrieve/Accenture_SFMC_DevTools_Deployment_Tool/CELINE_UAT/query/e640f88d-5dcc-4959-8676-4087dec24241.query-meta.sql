SELECT
    Account.PersonContactId AS 'Contact Key',
    Transactions.cel_AccountId__c AS 'Account Id',
    Transactions.Id AS 'Transaction Id',
    Transactions.cel_transaction_accounting_date__c AS 'Transaction Accounting Date'
FROM
    ENT.cel_Transaction__c_Salesforce AS Transactions
    LEFT OUTER JOIN ENT.ACCOUNT_SALESFORCE AS Account ON Transactions.cel_AccountId__c = Account.Id
WHERE
    Account.RecordTypeId = '0121r0000007NppAAE'
    AND Account.cel_ext_account_id__c IS NOT NULL