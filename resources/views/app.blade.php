<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Hatchery</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <link rel="manifest" href="manifest.json" />
    <link rel="shortcut icon" href="favicon.png" />
    <link rel="stylesheet" type="text/css" href="{{ secure_asset('css/vendor/fontawesome.min.css') }}" />
    <!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css"> -->

    <link rel="stylesheet" type="text/css" href="{{ secure_asset('css/styles.css') }}" />
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script> -->
    <!-- <script src="{{ secure_asset('js/socket-client.js') }}"></script> -->
    <meta property="og:title"              content="Hatchery | WHERE CREATORS ARE COLLABORATORS" />
    <meta property="og:description"        content="Be part of the platform that connects brands to influencers in a fast and convenient way." />
    <meta property="og:image"              content="https://dev.bcdpinpoint.com/influencer/public/images/OGimage.jpg" />
    <meta property="fb:app_id"              content="444577043132712" />
    <meta property="og:url"              content="https://dev.bcdpinpoint.com/influencer/public/" />
    <meta property="og:type"              content="hatchery:photo" />
    <script>
      window.fbAsyncInit = function() {
        FB.init({
          appId            : '444577043132712',
          autoLogAppEvents : true,
          xfbml            : true,
          version          : 'v6.0'
        });
      };
    </script>
  </head>
  <body>
    <div id="app"></div>

    <script src="{{ secure_asset('js/index.js') }}"></script>
    
  </body>
</html>
