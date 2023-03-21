
<!--#include file="../Connections/pigoConn.asp" -->

<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OFFICIAL PIGO</title>
    <link rel="icon" type="image/x-icon" href="<%=base_url%>/assets/logo/1.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/stylehome.css">
    <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
    <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>
    <script src="<%=base_url%>/js/sw/sweetalert2.all.min.js"></script>
        
    </head>
    <style>
    .Chat-Live{
      background:red;
      padding:10px 10px;
    }
        .msg_container_base {
        background: #e5e5e5;
        margin: 0;
        padding: 0 10px 10px;
        max-height: 80vh;
        overflow-x: hidden;
        }

        .top-bar {
        background: #666;
        color: white;
        padding: 10px;
        position: relative;
        overflow: hidden;
        }

        .msg_receive {
        padding-left: 0;
        margin-left: 0;
        }

        .msg_sent {
        padding-bottom: 20px !important;
        margin-right: 0;
        }

        .messages {
            background: #ffffff;
      padding: 5px 20px;
      border-radius: 50px;
      font-size: 12px;
      font-weight: 550;
      box-shadow: 0 1px 2px rgba(230, 172, 172, 0.2);
        }

        .messages > p {
        font-size: 13px;
        margin: 0 0 0.2rem 0;
        }

        .messages > time {
        font-size: 11px;
        color: #ccc;
        }

        .msg_container {
        padding: 10px;
        overflow: hidden;
        display: flex;
        }

        img {
        display: block;
        width: 100%;
        }

        .avatar {
        position: relative;
        }

        .base_receive > .avatar:after {
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 0;
        height: 0;
        border: 5px solid #FFF;
        border-left-color: rgba(0, 0, 0, 0);
        border-bottom-color: rgba(0, 0, 0, 0);
        }

        .base_sent {
        justify-content: flex-end;
        align-items: flex-end;
        }

        .base_sent > .avatar:after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 0;
        border: 5px solid white;
        border-right-color: transparent;
        border-top-color: transparent;
        box-shadow: 1px 1px 2px rgba(black, 0.2); // not quite perfect but close
        }

        .msg_sent > time {
        float: right;
        }

        .msg_container_base::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #F5F5F5;
        }

        .msg_container_base::-webkit-scrollbar {
        width: 12px;
        background-color: #F5F5F5;
        }

        .msg_container_base::-webkit-scrollbar-thumb {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
        background-color: #555;
        }

        .btn-group.dropup {
        position: fixed;
        left: 0px;
        bottom: 0;
        }

    </style>
<body>
  <div class="Chat-Live">
    <div class="row">
      <div class="col-12">
      </div>
    </div>
  </div>
  <div class="panel panel-primary" style="border:0px">
    <div class="panel-heading top-bar">
      <div class="col-md-8 col-xs-8">
        <h3 class="panel-title"><span class="glyphicon glyphicon-comment" style="margin-right:6px;"></span>College Enquiry Chat</h3>
      </div>
    </div>


    <div class="panel-body msg_container_base">

      <div class="row msg_container base_sent">
        <div class="col-md-10 col-xs-10">
          <div class="messages msg_sent">
            <p>that mongodb thing looks good, huh? tiny master db, and huge document store</p>
          </div>
        </div>
      </div>

      <div class="row msg_container base_receive">
        <div class="col-md-10 col-xs-10">
          <div class="messages msg_receive">
            <p>that mongodb thing looks good, huh? tiny master db, and huge document store</p>
          </div>
        </div>
      </div>

      <chat_log> . </chat_log>
    </div>

    <!--CHAT USER BOX-->
    <div class="panel-footer">
      <div class="input-group" id="myForm">
        <input id="btn-input" type="text" class="form-control input-sm chat_input" placeholder="Write your message here...">
        <span class="input-group-btn">
                        <button class="btn btn-primary btn-sm" id="submit" type="submit">Send</button>
                        </span>
      </div>
    </div>



</body>
    <script>
       $("#submit").click(function() {
        var data = $("#btn-input").val();
        //console.log(data);
        $('chat_log').append('<div class="row msg_container base_sent"><div class="col-md-10 col-xs-10"><div class="messages msg_receive"><p>' + data + '</p></div></div></div><div class="row msg_container base_receive"><div class="col-md-10 col-xs-10"><div class="messages msg_receive"><p>' + data + '</p></div></div></div>');
        clearInput();
        console.log($('.msg_container_base').innerHeight())
        $('.msg_container_base').scrollTop($('.msg_container_base')[0].scrollHeight)
    });

function clearInput() {
  $("#myForm :input").each(function() {
    $(this).val(''); //hide form values
  });
}

$("#myForm").submit(function() {
  return false; //to prevent redirection to save.php
});
        </script>
</html>