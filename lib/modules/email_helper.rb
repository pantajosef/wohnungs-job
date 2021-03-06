require "mail"
require_relative "../initializers/present"
require_relative "../initializers/mail_defaults"

module EmailHelper
  class ArgumentsMissingError < StandardError; end

  class << self
    def send_mail(options = {})
      raise ArgumentsMissingError unless required_args_present?(options)

      html_body = build_email_body(options[:html_options])

      mail = Mail.new do
        to options[:recipient]
        from ENV["SMTP_FROM"]
        subject options[:subject]

        text_part do
          body "Hi there, I am here to notify you of a change in the flat offers of the site #{options[:html_options][:name]}!\n\rJust click on the button to go to the site. Go to #{options[:html_options][:name]}!\n\rYou will receive further notifications as soon as I get updates from all the MS flat sites.\n\rGood luck! Happy Hunting"
        end

        html_part do
          content_type "text/html; charset=UTF-8"
          body html_body
        end
      end

      mail.delivery_method options[:delivery_method] if options[:delivery_method].present?

      mail.deliver!
    end

    private

    def required_args_present?(args)
      args[:recipient].present? && args[:subject].present? && args[:html_options].present?
    end

    def build_email_body(options)
      return build_error_email_body(options) if options.delete(:error)

      <<-HTML_STRING
      <!doctype html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width" />
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
          <title>MS FLat Search Notification</title>
          <style>
            /* -------------------------------------
                GLOBAL RESETS
            ------------------------------------- */
            img {
              border: none;
              -ms-interpolation-mode: bicubic;
              max-width: 100%; }
            body {
              background-color: #f6f6f6;
              font-family: sans-serif;
              -webkit-font-smoothing: antialiased;
              font-size: 14px;
              line-height: 1.4;
              margin: 0;
              padding: 0;
              -ms-text-size-adjust: 100%;
              -webkit-text-size-adjust: 100%; }
            table {
              border-collapse: separate;
              mso-table-lspace: 0pt;
              mso-table-rspace: 0pt;
              width: 100%; }
              table td {
                font-family: sans-serif;
                font-size: 14px;
                vertical-align: top; }
            /* -------------------------------------
                BODY & CONTAINER
            ------------------------------------- */
            .body {
              background-color: #f6f6f6;
              width: 100%; }
            /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
            .container {
              display: block;
              Margin: 0 auto !important;
              /* makes it centered */
              max-width: 580px;
              padding: 10px;
              width: 580px; }
            /* This should also be a block element, so that it will fill 100% of the .container */
            .content {
              box-sizing: border-box;
              display: block;
              Margin: 0 auto;
              max-width: 580px;
              padding: 10px; }
            /* -------------------------------------
                HEADER, FOOTER, MAIN
            ------------------------------------- */
            .main {
              background: #ffffff;
              border-radius: 3px;
              width: 100%; }
            .wrapper {
              box-sizing: border-box;
              padding: 20px; }
            .content-block {
              padding-bottom: 10px;
              padding-top: 10px;
            }
            .footer {
              clear: both;
              Margin-top: 10px;
              text-align: center;
              width: 100%; }
              .footer td,
              .footer p,
              .footer span,
              .footer a {
                color: #999999;
                font-size: 12px;
                text-align: center; }
            /* -------------------------------------
                TYPOGRAPHY
            ------------------------------------- */
            h1,
            h2,
            h3,
            h4 {
              color: #000000;
              font-family: sans-serif;
              font-weight: 400;
              line-height: 1.4;
              margin: 0;
              margin-bottom: 30px; }
            h1 {
              font-size: 35px;
              font-weight: 300;
              text-align: center;
              text-transform: capitalize; }
            p,
            ul,
            ol {
              font-family: sans-serif;
              font-size: 14px;
              font-weight: normal;
              margin: 0;
              margin-bottom: 15px; }
              p li,
              ul li,
              ol li {
                list-style-position: inside;
                margin-left: 5px; }
            a {
              color: #3498db;
              text-decoration: underline; }
            /* -------------------------------------
                BUTTONS
            ------------------------------------- */
            .btn {
              box-sizing: border-box;
              width: 100%; }
              .btn > tbody > tr > td {
                padding-bottom: 15px; }
              .btn table {
                width: auto; }
              .btn table td {
                background-color: #ffffff;
                border-radius: 5px;
                text-align: center; }
              .btn a {
                background-color: #{options[:button_color]} !important;
                border: solid 1px #{options[:button_color]} !important;
                border-radius: 5px;
                box-sizing: border-box;
                color: #ffffff;
                cursor: pointer;
                display: inline-block;
                font-size: 14px;
                font-weight: bold;
                margin: 0;
                padding: 12px 25px;
                text-decoration: none;
                text-transform: capitalize; }
            .btn-primary table td {
              background-color: #{options[:button_color]} !important; }
            .btn-primary a {
              background-color: #{options[:button_color]} !important;
              border-color: #{options[:button_color]} !important;
              color: rgb(255, 255, 255) !important;
              text-decoration: none !important;
              padding: 10px 12px;
              line-height: 1.5;
              border-style: solid;
              border-color: #{options[:button_color]};
              border-width: 1px; }
            /* -------------------------------------
                OTHER STYLES THAT MIGHT BE USEFUL
            ------------------------------------- */
            .last {
              margin-bottom: 0; }
            .first {
              margin-top: 0; }
            .align-center {
              text-align: center; }
            .align-right {
              text-align: right; }
            .align-left {
              text-align: left; }
            .clear {
              clear: both; }
            .mt0 {
              margin-top: 0; }
            .mb0 {
              margin-bottom: 0; }
            .preheader {
              color: transparent;
              display: none;
              height: 0;
              max-height: 0;
              max-width: 0;
              opacity: 0;
              overflow: hidden;
              mso-hide: all;
              visibility: hidden;
              width: 0; }
            .powered-by a {
              text-decoration: none; }
            hr {
              border: 0;
              border-bottom: 1px solid #f6f6f6;
              Margin: 20px 0; }
            /* -------------------------------------
                RESPONSIVE AND MOBILE FRIENDLY STYLES
            ------------------------------------- */
            @media only screen and (max-width: 620px) {
              table[class=body] h1 {
                font-size: 28px !important;
                margin-bottom: 10px !important; }
              table[class=body] p,
              table[class=body] ul,
              table[class=body] ol,
              table[class=body] td,
              table[class=body] span,
              table[class=body] a {
                font-size: 16px !important; }
              table[class=body] .wrapper,
              table[class=body] .article {
                padding: 10px !important; }
              table[class=body] .content {
                padding: 0 !important; }
              table[class=body] .container {
                padding: 0 !important;
                width: 100% !important; }
              table[class=body] .main {
                border-left-width: 0 !important;
                border-radius: 0 !important;
                border-right-width: 0 !important; }
              table[class=body] .btn table {
                width: 100% !important; }
              table[class=body] .btn a {
                width: 100% !important; }
              table[class=body] .img-responsive {
                height: auto !important;
                max-width: 100% !important;
                width: auto !important; }}
            /* -------------------------------------
                PRESERVE THESE STYLES IN THE HEAD
            ------------------------------------- */
            @media all {
              .ExternalClass {
                width: 100%; }
              .ExternalClass,
              .ExternalClass p,
              .ExternalClass span,
              .ExternalClass font,
              .ExternalClass td,
              .ExternalClass div {
                line-height: 100%; }
              .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important; }
              .btn-primary table td:hover {
                background-color: #{options[:button_hover_color]} !important; }
              .btn-primary a:hover {
                background-color: #{options[:button_hover_color]} !important;
                border-color: #{options[:button_hover_color]} !important; } }
          </style>
        </head>
        <body class="">
          <!-- START: Hidden Preheader Text -->
          <div style="display:none;font-size:1px;color:#333333;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;">
            Hi there, I am here to notify you of a change in the flat offers of the site #{options[:name]}!
          </div>

          <!-- Insert &zwnj;&nbsp; hack after hidden preview text -->
          <div style="display: none; max-height: 0px; overflow: hidden;">
          &nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;
          </div>

          <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
            <tr>
              <td>&nbsp;</td>
              <td class="container">
                <div class="content">

                  <!-- START CENTERED WHITE CONTAINER -->
                  <span class="preheader">This is preheader text. Some clients will show this text as a preview.</span>
                  <table role="presentation" class="main">

                    <!-- START MAIN CONTENT AREA -->
                    <tr>
                      <td class="wrapper">
                        <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td>
                              <p>Hi there,</p>
                              <p>I am here to notify you of a change in the flat offers of the site #{options[:name]}! Just click on the button to go to the site.</p>
                              <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="btn btn-primary">
                                <tbody>
                                  <tr>
                                    <td align="left">
                                      <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                          <tr>
                                            <td> <a href="#{options[:url]}" target="_blank">Go to #{options[:name]}!</a></td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                              <p>You will receive further notifications as soon as I get updates from all the MS flat sites.</p>
                              <p>Good luck! Happy Hunting!</p>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>

                  <!-- END MAIN CONTENT AREA -->
                  </table>

                  <!-- START FOOTER -->
                  <div class="footer">
                    <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td class="content-block powered-by">
                          Powered by <a href="http://htmlemail.io">HTMLemail</a>.
                        </td>
                      </tr>
                    </table>
                  </div>
                  <!-- END FOOTER -->

                <!-- END CENTERED WHITE CONTAINER -->
                </div>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </body>
      </html>
      HTML_STRING
    end

    def build_error_email_body(options)
      <<-HTML_STRING
      <!doctype html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width" />
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
          <title>MS FLat Search Notification</title>
          <style>
            /* -------------------------------------
                GLOBAL RESETS
            ------------------------------------- */
            img {
              border: none;
              -ms-interpolation-mode: bicubic;
              max-width: 100%; }
            body {
              background-color: #f6f6f6;
              font-family: sans-serif;
              -webkit-font-smoothing: antialiased;
              font-size: 14px;
              line-height: 1.4;
              margin: 0;
              padding: 0;
              -ms-text-size-adjust: 100%;
              -webkit-text-size-adjust: 100%; }
            table {
              border-collapse: separate;
              mso-table-lspace: 0pt;
              mso-table-rspace: 0pt;
              width: 100%; }
              table td {
                font-family: sans-serif;
                font-size: 14px;
                vertical-align: top; }
            /* -------------------------------------
                BODY & CONTAINER
            ------------------------------------- */
            .body {
              background-color: #f6f6f6;
              width: 100%; }
            /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
            .container {
              display: block;
              Margin: 0 auto !important;
              /* makes it centered */
              max-width: 580px;
              padding: 10px;
              width: 580px; }
            /* This should also be a block element, so that it will fill 100% of the .container */
            .content {
              box-sizing: border-box;
              display: block;
              Margin: 0 auto;
              max-width: 580px;
              padding: 10px; }
            /* -------------------------------------
                HEADER, FOOTER, MAIN
            ------------------------------------- */
            .main {
              background: #ffffff;
              border-radius: 3px;
              width: 100%; }
            .wrapper {
              box-sizing: border-box;
              padding: 20px; }
            .content-block {
              padding-bottom: 10px;
              padding-top: 10px;
            }
            .footer {
              clear: both;
              Margin-top: 10px;
              text-align: center;
              width: 100%; }
              .footer td,
              .footer p,
              .footer span,
              .footer a {
                color: #999999;
                font-size: 12px;
                text-align: center; }
            /* -------------------------------------
                TYPOGRAPHY
            ------------------------------------- */
            h1,
            h2,
            h3,
            h4 {
              color: #000000;
              font-family: sans-serif;
              font-weight: 400;
              line-height: 1.4;
              margin: 0;
              margin-bottom: 30px; }
            h1 {
              font-size: 35px;
              font-weight: 300;
              text-align: center;
              text-transform: capitalize; }
            p,
            ul,
            ol {
              font-family: sans-serif;
              font-size: 14px;
              font-weight: normal;
              margin: 0;
              margin-bottom: 15px; }
              p li,
              ul li,
              ol li {
                list-style-position: inside;
                margin-left: 5px; }
            a {
              color: #3498db;
              text-decoration: underline; }
            /* -------------------------------------
                BUTTONS
            ------------------------------------- */
            .btn {
              box-sizing: border-box;
              width: 100%; }
              .btn > tbody > tr > td {
                padding-bottom: 15px; }
              .btn table {
                width: auto; }
              .btn table td {
                background-color: #ffffff;
                border-radius: 5px;
                text-align: center; }
              .btn a {
                background-color: #DC143C !important;
                border: solid 1px #DC143C !important;
                border-radius: 5px;
                box-sizing: border-box;
                color: #FFFFFF !important;
                cursor: pointer;
                display: inline-block;
                font-size: 14px;
                font-weight: bold;
                margin: 0;
                padding: 12px 25px;
                text-decoration: none;
                text-transform: capitalize; }
            .btn-primary table td {
              background-color: #DC143C !important; }
            .btn-primary a {
              background-color: #DC143C !important;
              border-color: #DC143C !important;
              color: rgb(255, 255, 255) !important;
              text-decoration: none !important;
              padding: 10px 12px;
              line-height: 1.5;
              border-style: solid;
              border-color: #DC143C;
              border-width: 1px; }
            /* -------------------------------------
                OTHER STYLES THAT MIGHT BE USEFUL
            ------------------------------------- */
            .last {
              margin-bottom: 0; }
            .first {
              margin-top: 0; }
            .align-center {
              text-align: center; }
            .align-right {
              text-align: right; }
            .align-left {
              text-align: left; }
            .clear {
              clear: both; }
            .mt0 {
              margin-top: 0; }
            .mb0 {
              margin-bottom: 0; }
            .preheader {
              color: transparent;
              display: none;
              height: 0;
              max-height: 0;
              max-width: 0;
              opacity: 0;
              overflow: hidden;
              mso-hide: all;
              visibility: hidden;
              width: 0; }
            .powered-by a {
              text-decoration: none; }
            hr {
              border: 0;
              border-bottom: 1px solid #f6f6f6;
              Margin: 20px 0; }
            /* -------------------------------------
                RESPONSIVE AND MOBILE FRIENDLY STYLES
            ------------------------------------- */
            @media only screen and (max-width: 620px) {
              table[class=body] h1 {
                font-size: 28px !important;
                margin-bottom: 10px !important; }
              table[class=body] p,
              table[class=body] ul,
              table[class=body] ol,
              table[class=body] td,
              table[class=body] span,
              table[class=body] a {
                font-size: 16px !important; }
              table[class=body] .wrapper,
              table[class=body] .article {
                padding: 10px !important; }
              table[class=body] .content {
                padding: 0 !important; }
              table[class=body] .container {
                padding: 0 !important;
                width: 100% !important; }
              table[class=body] .main {
                border-left-width: 0 !important;
                border-radius: 0 !important;
                border-right-width: 0 !important; }
              table[class=body] .btn table {
                width: 100% !important; }
              table[class=body] .btn a {
                width: 100% !important; }
              table[class=body] .img-responsive {
                height: auto !important;
                max-width: 100% !important;
                width: auto !important; }}
            /* -------------------------------------
                PRESERVE THESE STYLES IN THE HEAD
            ------------------------------------- */
            @media all {
              .ExternalClass {
                width: 100%; }
              .ExternalClass,
              .ExternalClass p,
              .ExternalClass span,
              .ExternalClass font,
              .ExternalClass td,
              .ExternalClass div {
                line-height: 100%; }
              .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important; }
              .btn-primary table td:hover {
                background-color: #C40027 !important; }
              .btn-primary a:hover {
                background-color: #C40027 !important;
                border-color: #C40027 !important; } }
          </style>
        </head>
        <body class="">
          <!-- START: Hidden Preheader Text -->
          <div style="display:none;font-size:1px;color:#333333;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;">
            Hi there, I am here to notify you of an error that has occurred during my search for flats!
          </div>

          <!-- Insert &zwnj;&nbsp; hack after hidden preview text -->
          <div style="display: none; max-height: 0px; overflow: hidden;">
          &nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;
          </div>

          <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
            <tr>
              <td>&nbsp;</td>
              <td class="container">
                <div class="content">

                  <!-- START CENTERED WHITE CONTAINER -->
                  <span class="preheader">This is preheader text. Some clients will show this text as a preview.</span>
                  <table role="presentation" class="main">

                    <!-- START MAIN CONTENT AREA -->
                    <tr>
                      <td class="wrapper">
                        <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td>
                              <p>Hi there,</p>
                              <p>I am here to notify you of the following error that has occurred during my search for flats!</p>
                              <p>Don't worry. I'll keep searching for you. However, you may want to have a look at this error later on.</p>
                              <p>This error occurred:</p>
                              <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="btn btn-primary">
                                <tbody>
                                  <tr>
                                    <td align="left">
                                      <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                          <tr>
                                            <td> <a href="#">#{options[:error_object].class.to_s}!</a></td>
                                          </tr>
                                          <tr>
                                          <td> <p>#{options[:error_object].message}</p> </td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                              <p>You will receive further notifications as soon as I get updates from all the MS flat sites.</p>
                              <p>Good luck! Happy Hunting!</p>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>

                  <!-- END MAIN CONTENT AREA -->
                  </table>

                  <!-- START FOOTER -->
                  <div class="footer">
                    <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td class="content-block powered-by">
                          Powered by <a href="http://htmlemail.io">HTMLemail</a>.
                        </td>
                      </tr>
                    </table>
                  </div>
                  <!-- END FOOTER -->

                <!-- END CENTERED WHITE CONTAINER -->
                </div>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </body>
      </html>
      HTML_STRING
    end
  end
end
