<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Hatchery</title>
</head>
<body style="background-color:#eee;color:#231f20;font-size:14px;font-family:Arial;">
    <table cellspacing=0 cellpadding=0 width='800' style="background-color: #eee;" align='center'>
        <tr>
            <td style='padding-top: 20px; padding-bottom: 20px; text-align: right; width: 350px'>
                <img src="http://dev.bcdpinpoint.com/influencer/public/images/app-logo.png" alt="">
            </td>
            <td style='padding-left: 10px; padding-top: 20px; padding-bottom: 20px; text-align: left;'>
                <p style='color:#5d5d5d;font-size:32px;font-family:Arial; text-align: left; font-weight: bold'>
                    Hatchery
                </p>
            </td>
        </tr>
    </table>

    <table cellspacing=0 cellpadding=0 width='800' style="padding-bottom: 30px;background-color: #fff; border-top: 4px solid #d7545e" align="center">
        <tr>
            <td style='padding-left: 10px; padding-top: 30px; padding-bottom: 50px; text-align: center;'>
                <p style='color:#231f20;font-size:23px;font-family:Arial; text-align: center; font-weight: bold'>Problem Reported</p>
            </td>
        </tr>
        <tr>
            <td style='padding-left: 25px; padding-right: 25px; padding-bottom: 50px; text-align: center;'>
                <p style='color:#231f20;font-size:18px;font-family:Arial; text-align: left;'>
                    <strong>Inquiry Type: </strong>{{ $problem->subject }}
                </p>
                <p style='color:#231f20;font-size:18px;font-family:Arial; text-align: left;'>
                    <strong>Title: </strong>{{ $problem->title }}
                </p>
                <p style='color:#231f20;font-size:18px;font-family:Arial; text-align: left;'>
                    <strong>From: </strong>{{ $problem->email }}
                </p>
                <br>
                <p style='color:#231f20;font-size:18px;font-family:Arial; text-align: left;'>
                    <strong>Message:</strong><br>{{ $problem->message }}
                </p>
            </td>
        </tr>
        <tr>
            <td>
                <table cellspacing=0 cellpadding=0 width='750' style="background-color: #fff;border-top: 1px solid #dedede" align="center">
                    <tr>
                        <td style='padding-left: 0; padding-right: 0; padding-top: 18px; padding-bottom: 10px; text-align: left;'>
                            <p style='color:#929292;font-size:13px;font-family:Arial; text-align: left; '>
                                Sent through Hatchery App. Do not reply.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
    </table>
</body>
</html>