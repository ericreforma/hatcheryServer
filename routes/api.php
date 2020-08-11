<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
// Image Files
Route::get('/storage/{path}/{filename}', function ($path, $filename){
  $path = storage_path('app/' . $path .'/'. $filename);
  $file = File::get($path);
  $type = File::mimeType($path);

  $response = Response::make($file, 200);
  $response->header("Content-Type", $type);

  return $response;
});


Route::middleware('auth:web')->group(function(){
  Route::get('/auth/handler','FacebookAuthController@handleProviderCallback')->name('auth_handler');
  Route::get('/auth/facebook','FacebookAuthController@redirectToProvider')->name('auth_facebook');
});

Route::middleware('json.response')->group(function(){

  // USER
  Route::prefix('user')->group(function(){
    
    // Regular Auth
    //Route::post('login', 'API\AuthUserController@login')->name('user_login');
    //Route::post('signup', 'API\AuthUserController@signup')->name('user_signup');


    // FIREBASE LOGIN
    Route::prefix('firebase')->group(function(){
      Route::post('login', 'API\AuthUserController@firebaseLogin')->name('firebase_login');

      // Route::post('/signup', 'UserController@signup')->name('firebase_signup');
    });

    Route::middleware('auth:api')->group(function(){
      // FIREBASE USER TEST
        // Route::get('/firebaseTest', 'UserController@firebaseUserTest');
        // returns nothing

      // EMAIL VERIFICATION
        Route::post('/verifyCode', 'UserController@verifyCode');
        Route::get('/verifyCodeResend', 'UserController@verifyCodeResend');

      
      // Chat
      Route::prefix('chat')->group(function(){
        Route::prefix('session')->group(function(){
          Route::get('/create', 'UserController@chatSession_create');
          Route::get('/list', 'UserController@chatSession_list');
        });
        
        Route::post('/send', 'UserController@chat_send');
        Route::get('delete','UserController@chat_delete');
        Route::get('/history', 'UserController@chat_history');
      });

      // USER details
      Route::get('/', 'UserController@details');
      Route::get('logout', 'UserController@logout')->name('user_logout');
      Route::post('update','UserController@profileUpdate');
      Route::get('category/browse','UserController@category_browse');
      Route::get('category/list','UserController@category_list');
      Route::post('category/save', 'UserController@category_save');
      Route::post('linkAccount', 'UserController@linkAccount');
      
      // My campaigns
      Route::get('/campaign/list','CampaignController@my_list');
      Route::post('/campaign/add','UserController@campaign_add');

      // Campaigns
      Route::get('/client/campaign/browse','CampaignController@browse');
      Route::get('/client/campaign/details','CampaignController@campaign_details');
      Route::get('/client/campaign/interested','CampaignController@interested');
      Route::get('/client/campaign/uninterested','CampaignController@removeInterested');
      Route::get('/client/campaign/viewall','CampaignController@viewall');
      
      Route::prefix('socialmedia')->group(function(){
        // Posts
        Route::post('/post/add','UserSocialMediaController@post_add');
        Route::post('/post/update','UserSocialMediaController@post_update');
        Route::get('/post/cancel','UserSocialMediaController@post_cancel');
        Route::get('/post/details','UserSocialMediaController@post_details');
        Route::post('/post/liveSubmit','UserSocialMediaController@post_live_submit');
        Route::get('/post/setFeatured','UserSocialMediaController@post_setFeatured');
      });

      // Events
      Route::post('/event/apply','UserEventController@applicationSubmit');

      // Tests
      Route::get('/testFirst','UserController@testFirst');
      Route::get('/testMail','UserController@testMail');

      // Report a Problem
      Route::post('/reportProblem', 'UserController@reportProblem');

      // Notifications 
      Route::prefix('notification')->group(function(){
        Route::get('/','NotificationController@get');
        Route::get('/opened','NotificationController@opened');
        Route::post('notify_device','NotificationController@notify_device');
      });
      
      // FCM 
      Route::prefix('fcm')->group(function(){
        Route::get('/token_update','UserController@fcm_token_update');
      });
      
    });

  });

  // CLIENT
  Route::prefix('client')->group(function(){

      Route::get('home', 'API\AuthClientController@index');
      Route::post('/login', 'API\AuthClientController@login');
      Route::post('/signup', 'API\AuthClientController@signup');
      
      

      // SOCIAL MEDIA LOGIN
      
      Route::middleware('auth:web_api')->group(function(){
        // Firebase
        Route::prefix('firebase')->group(function(){
          Route::post('/login', 'ClientController@login');
          Route::post('/signup', 'ClientController@signup');
        });

        Route::get('/profile','ClientController@details');
        Route::get('logout', 'UserController@logout')->name('user_logout');

        Route::get('categories','ClientController@categories');
        Route::get('skills','ClientController@skills');
        Route::get('jobs','ClientController@jobs');
        
        Route::get('users','ClientController@users');

        // CAMPAIGN
        Route::prefix('campaign')->group(function(){
          Route::get('/list', 'ClientController@campaign_list');

          Route::prefix('user')->group(function(){
            Route::get('/list', 'ClientController@campaign_user_list');
          });
        });
        
        // SocialMedia 
        Route::prefix('socialmedia')->group(function(){
          Route::post('/publish', 'ClientSocialMediaController@publish');
          Route::get('/list', 'ClientSocialMediaController@list');
          Route::get('/details/{id}', 'ClientSocialMediaController@details');

          // USERS
            Route::prefix('/user')->group(function(){
              Route::get('/', 'ClientSocialMediaController@user_list');
              Route::get('/posts', 'ClientSocialMediaController@user_posts');
            });

          // POSTS
            Route::prefix('/post')->group(function(){
              Route::get('list','ClientSocialMediaController@posts');
              Route::post('/changestatus', 'ClientSocialMediaController@post_change_status');
              Route::post('online/remove','ClientSocialMediaController@post_online_remove');
            });
            
        });

        // EVENT
        Route::prefix('event')->group(function(){
          Route::post('/publish', 'ClientEventController@publish');
          Route::get('/list', 'ClientEventController@list');
          
          Route::get('/details/{id}', 'ClientEventController@details');
          
          Route::prefix('applicant')->group(function(){
            Route::get('/profile','ClientEventController@applicant_profile');
            Route::get('/setStatus', 'ClientEventController@applicant_setStatus');
          });

          Route::prefix('job')->group(function(){
            Route::get('/list','ClientEventController@job_list');
          });
          
        });

        // INFLUENCERS
        Route::prefix('influencer')->group(function(){
          Route::get('/profile', 'ClientController@influencer_profile');
        });
        
        // CHAT 
            Route::prefix('chat')->group(function(){
              Route::prefix('session')->group(function(){
                Route::get('/','ClientController@chatSession_get');
                Route::get('create','ClientController@chatSession_create');
                Route::get('list','ClientController@chatSession_list');
              });
              Route::get('messages','ClientController@chat_messages');
              Route::post('send','ClientController@chat_send');
              Route::get('delete','ClientController@chat_delete');
            });

        // TEST Notification
            Route::prefix('notification')->group(function(){
              Route::get('test', 'NotificationController@test');
            });

        // Test Image upload for thumbnail
            Route::prefix('test')->group(function(){
              Route::post('imageUpload', 'TestController@ImageUpload');
              Route::get('mail', 'TestController@mail');
            });

        // TEST EMAIL

      });

  });

  // SETTINGS ENVIRONMENT
    Route::prefix('env')->group(function(){
    // COUNTRY
      Route::prefix('country')->group(function(){
        Route::get('/list', 'CountryController@get_list');
      });
    });
    
});
