Platform.Load('Core', '1.1.1');
var subs = DataExtension.Init('6985DFB6-167D-4427-AF4B-D23903B8BA39');
var data = subs.Rows.Retrieve();

try {
    for (var i = 0; i < data.length; i++) {
        var subkey = data[i].ContactKey;
        var email = data[i].Email;
        var status = data[i].Status;

        var prox = new Script.Util.WSProxy();

        // Set specific BU context if required
        prox.setClientId({ ID: 510003815 });

        var sub = {
            SubscriberKey: subkey,
            EmailAddress: email,
            Status: status,
            Lists: [
                {
                    ID: '82',
                    Status: 'Active'
                }
            ]
        };
        var options = {
            SaveOptions: [
                {
                    PropertyName: '*',
                    SaveAction: 'UpdateAdd'
                }
            ]
        };
        try {
            var resp = prox.createItem('Subscriber', sub, options);
        } catch (e) {
            action = 'error';
        }
    }
} catch (e) {
    action = 'error';
}
