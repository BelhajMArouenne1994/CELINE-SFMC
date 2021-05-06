Platform.Load('core', '1');
try {
    var accDE = DataExtension.Init('Hard Bounces');
    var data = retrieveAllRecords('Hard Bounces');
    if (data) {
        for (var i = 0; i < data.length; i++) {
            /* Update the Account record who had a HardBounce */
            var accountId, personEmail, dateHardBounce;
            var accountId = data[i]['Account Id'];
            var personEmail = data[i]['PersonEmail'];
            var dateHardBounce = data[i]['Date'];
            if (accountId && accountId != '') {
                var sf_fieldUpdateString = [];
                sf_fieldUpdateString.push('HasOptedOutOfEmail');
                sf_fieldUpdateString.push(1);

                /* The field will be uncommented when IN SF Sales Cloud a field containing the date of the HardBounce */
                //sf_fieldUpdateString.push('API NAME OF THE FIELD');
                //sf_fieldUpdateString.push(dateHardBounce);

                var updateSFObject = '';
                updateSFObject += '%%[ ';
                updateSFObject += "set @salesforceFields = UpdateSingleSalesforceObject('Account',";
                updateSFObject += "'" + contactID + "','" + sf_fieldUpdateString.join("','") + "'";
                updateSFObject += ') ';
                updateSFObject += 'output(concat(@salesforceFields)) ';
                updateSFObject += ']%%';

                try {
                    results = Platform.Function.TreatAsContent(updateSFObject);
                } catch (e) {
                    if (debug) {
                        Write('<br>updateSFHasOptedOutOfEmailFlag error: ' + Stringify(e));
                    }
                }
            }
        }
    }
} catch (error) {}

function retrieveFieldNames(name) {
    var attr = DataExtension.Retrieve({ Property: 'Name', SimpleOperator: 'equals', Value: name });

    var de = DataExtension.Init(attr[0].CustomerKey);

    var fields = de.Fields.Retrieve();

    fields.sort(function (a, b) {
        return a.Ordinal > b.Ordinal ? 1 : -1;
    });

    var out = [];

    for (k in fields) {
        out = out.concat(fields[k].Name);
    }

    return out;
}

function retrieveAllRecords(name) {
    var prox = new Script.Util.WSProxy();

    var cols = retrieveFieldNames(name);

    var config = {
        name: name,
        cols: cols
    };

    var records = [],
        moreData = true,
        reqID = (data = null);

    while (moreData) {
        moreData = false;

        if (reqID == null) {
            data = prox.retrieve('DataExtensionObject[' + config.name + ']', config.cols);
        } else {
            data = prox.getNextBatch('DataExtensionObject[' + config.name + ']', reqID);
        }

        if (data != null) {
            moreData = data.HasMoreRows;
            reqID = data.RequestID;
            for (var i = 0; i < data.Results.length; i++) {
                var result_list = data.Results[i].Properties;
                var obj = {};
                for (k in result_list) {
                    var key = result_list[k].Name;
                    var val = result_list[k].Value;
                    if (key.indexOf('_') != 0) obj[key] = val;
                }
                records.push(obj);
            }
        }
    }
    return records;
}

function retrieveSFAccountById(Id) {
    var retrieveSFObject = '';
    retrieveSFObject += '%%[ ';
    retrieveSFObject +=
        "set @salesforceFields = RetrieveSalesforceObjects('Account', 'Id, cel_PersonEmail__c, cel_email_2__c', 'cel_email_2__c', '=',";
    retrieveSFObject += "'" + Id + "'";
    retrieveSFObject += ') ';
    retrieveSFObject += 'output(concat(@salesforceFields)) ';
    retrieveSFObject += ']%%';

    try {
        results = Platform.Function.TreatAsContent(updateSFObject);
    } catch (e) {
        results = e;
    }
    return results;
}

function retrieveSFAccountByFirstEmail(nonValidEmail) {
    var retrieveSFObject = '';
    retrieveSFObject += '%%[ ';
    retrieveSFObject +=
        "set @salesforceFields = RetrieveSalesforceObjects('Account', 'Id, cel_PersonEmail__c, cel_email_2__c', 'cel_PersonEmail__c', '=',";
    retrieveSFObject += "'" + nonValidEmail + "'";
    retrieveSFObject += ') ';
    retrieveSFObject += 'output(concat(@salesforceFields)) ';
    retrieveSFObject += ']%%';

    try {
        results = Platform.Function.TreatAsContent(updateSFObject);
    } catch (e) {
        results = e;
    }
    return results;
}

function retrieveSFAccountBySecondtEmail(nonValidEmail) {
    var retrieveSFObject = '';
    retrieveSFObject += '%%[ ';
    retrieveSFObject +=
        "set @salesforceFields = RetrieveSalesforceObjects('Account', 'Id, cel_PersonEmail__c, cel_email_2__c', 'cel_email_2__c', '=',";
    retrieveSFObject += "'" + nonValidEmail + "'";
    retrieveSFObject += ') ';
    retrieveSFObject += 'output(concat(@salesforceFields)) ';
    retrieveSFObject += ']%%';

    try {
        results = Platform.Function.TreatAsContent(updateSFObject);
    } catch (e) {
        results = e;
    }
    return results;
}

function UpdateSFAccountValidity(Id, emailOrderValidity) {
    var sf_fieldUpdateString = [];
    var nonValidEmailValidity;

    if ((emailOrderValidity = 1)) {
        nonValidEmailValidity = '';
    } else {
        nonValidEmailValidity = '';
    }

    sf_fieldUpdateString.push(nonValidEmailValidity);
    sf_fieldUpdateString.push('false');

    /* The field will be uncommented when IN SF Sales Cloud a field containing the date of the HardBounce */
    //sf_fieldUpdateString.push('API NAME OF THE FIELD');
    //sf_fieldUpdateString.push(dateHardBounce);

    var updateSFObject = '';
    updateSFObject += '%%[ ';
    updateSFObject += "set @salesforceFields = UpdateSingleSalesforceObject('Account',";
    updateSFObject += "'" + Id + "','" + sf_fieldUpdateString.join("','") + "'";
    updateSFObject += ') ';
    updateSFObject += 'output(concat(@salesforceFields)) ';
    updateSFObject += ']%%';

    try {
        results = Platform.Function.TreatAsContent(updateSFObject);
    } catch (e) {}
}

//
