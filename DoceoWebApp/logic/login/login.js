function loginWithProvider(provider) {
  if (provider.localeCompare("Facebook") == 0) {

    FB.getLoginStatus(function(response) {
      if (response.status === 'connected') {
        // the user is logged in and has authenticated your
        // app, and response.authResponse supplies
        // the user's ID, a valid access token, a signed
        // request, and the time the access token
        // and signed request each expire
        var uid = response.authResponse.userID;
        var accessToken = response.authResponse.accessToken;

        AWS.config.region = 'us-east-1';
        AWS.config.credentials = new AWS.CognitoIdentityCredentials({
          IdentityPoolId: 'us-east-1:5a5ad151-a03d-4cac-b418-a9f661370566',
          Logins: {
            'graph.facebook.com': accessToken
          }
        });

        AWS.config.credentials.get(function(){
          // Access AWS resources here.
          getUserDynamoRow();
        });

        localStorage.setItem("Provider", "Facebook");
        localStorage.setItem("FacebookToken", accessToken);
        console.log('You are now logged in.');

      } else if (response.status === 'not_authorized') {
        // the user is logged in to Facebook,
        // but has not authenticated your app
      } else {
        // the user isn't logged in to Facebook.
        FB.login(function (response) {
          if (response.authResponse) { // logged in
            AWS.config.region = 'us-east-1';
            AWS.config.credentials = new AWS.CognitoIdentityCredentials({
              IdentityPoolId: 'us-east-1:5a5ad151-a03d-4cac-b418-a9f661370566',
              Logins: {
                'graph.facebook.com': response.authResponse.accessToken
              }
            });

            AWS.config.credentials.get(function(){
              // Access AWS resources here.
              getUserDynamoRow();
            });

            localStorage.setItem("Provider", "Facebook");
            localStorage.setItem("FacebookToken", response.authResponse.accessToken);

            console.log('You are now logged in.');
          } else {
            console.log('There was a problem logging you in.');
          }
        });
      }
    });



  }
  return false;
}

function getUserDynamoRow() {
  var table = new AWS.DynamoDB({params: {TableName: 'doceo-mobilehub-652118928-User'}});
  var key = AWS.config.credentials.identityId;
  console.log(key);

  table.getItem({Key: {userId: {S: key}}}, function(err, data) {
    console.log(data.Item); // print the item data
  });
}

function getUserStatus() {
   var provider = localStorage.getItem("Provider");

   if (provider == undefined) {
     console.log("User not logged in before");
   } else {
     loginWithProvider(provider);
   }
}
