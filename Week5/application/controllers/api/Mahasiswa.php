<?php

use Restserver\Libraries\REST_Controller;

defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH.'libraries/REST_Controller.php';

require APPPATH.'libraries/Format.php';

class Mahasiswa extends REST_Controller
{
    public function __construct($config = 'rest')
    {
        parent::__construct($config);

        $this->load->model('Mahasiswamodel', 'model');
    }

    public function index_get()
    {
        // Jika $this->load->model('Mahasiswamodel'); maka
        //  $data = $this->Mahasiswamodel->getMahasiswa();
        $data = $this->model->getMahasiswa();
        //Di bawah ini mengatur tampilan yang ada di postman. Biasa disebut response (Apa yang akan kita dapatkan).
        $this->set_response([
               'status' => true,
               'code' => 200,
               'message' => 'Success',
               'data' => $data,
                ], REST_Controller::HTTP_OK);
    }

    //Format yang dipakai adalah POST. Makanya _post
    public function sendmail_post()
    {
        //->post('email) == 'email' karena sebagai KEY pada Body bagian tab form-data di Postman.
        //'email' diisi pas ngirim request. Value 'email' adalah alamat tujuan.
        $to_email = $this->post('email');
        $this->load->library('email');
        $this->email->from('nazizah01@azizah.archotech.site', 'Nazizah WorkSpace');
        $this->email->to($to_email);
        $this->email->subject('Verifikasi Akun WorkSpace');
        $this->email->message('
        <!doctype html>
        <html lang="en">
            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">

                <style type="text/css">
                    img{
                        border-radius: 5%;
                    }

                    button{
                        color: white;                                             
                        background-color: #fe5436;
                        text-align: center;
                        padding: 13px;
                        border-radius: 30px;
                        border-style: none;                       
                    }

                    .header_text{
                        color: #fb4234;
                        font-size: 25px;
                        font-weight: 900;
                        margin-top: 20px;
                        margin-bottom: 23px;                        
                    }
                    
                    .container{
                        border-style: solid;
                        border-width: 5px;
                        border-color: #fc4a4a;
                        padding:0px 10px 0px 10px;
                    }
                    
                    .container1{
                        text-align: center;
                        border-top-left-radius: 40px;
                        border-top-right-radius: 40px;
                    }
                    
                    .container2 {
                        text-align: center;
                        border-top-style: none;
                        border-bottom-left-radius: 40px;
                        border-bottom-right-radius: 40px;
                        padding-top: 20px;
                        padding-bottom: 20px;
                    }
                    
                    .text_image{
                        font-size: 12px;
                        font-weight: 900;
                    }

                    .margin_text_image{
                        margin-top: 5px;
                    }
                    
                    .footer{
                        color: #fb4234;
                        font-size: 11px;
                    }
                    
                    .bolder{
                        font-weight: 900;
                    }
                    
                    .italic{
                        font-style: italic;
                    }

                    .margin_button{
                        margin-top: 23px;
                        margin-bottom: 20px;
                    }

                    .text_content{
                        font-size: 12px;
                    }

                    .margin_text_content{
                        margin-top: 17px;
                    }
                    
                    .margin_bigcontainer{
                        text-align: center;
                        margin-top: 23px;
                        margin-bottom: 23px;                      
                    }
                    
                    .colorblack{
                        color: black;
                    }

                    .bold{
                        font-weight: bold;
                    }
                </style>
            </head>
    
            <body>
                <div class="margin_bigcontainer">
                    <div class="container container1">
                    
                        <div class="header_text">Selamat bergabung di WorkSpace Nazizah!
                        </div>
                        <div>
                            <div>
                                <img src="http://azizah.archotech.site/nurazizah24/Week5/assets/images/template_verifikasi_email.jpg" width="330" height="250"/>
                            </div>
                            <div class="text_image margin_text_image colorblack">Terima kasih telah mendaftar pada WorkSpace Nazizah.
                            </div>
                        </div>
                        
                        <div class="colorblack margin_text_content">
                            <div class="text_content bold">Kami siap membantu Anda untuk meningkatkan kualitas <span class="bolder">proses donor darah</span> Anda.
                            </div>
                            <div class="text_content bold">Apabila Anda memang pernah melakukan pendaftaran sebagai <span class="italic">user</span> dalam WorkSpace Nazizah, silahkan klik tautan di bawah ini:
                            </div>
                        </div>
                        
                        <div class="margin_button">
                            <button><span class="text_image">Verifikasi akun</span>
                            </button>
                        </div>
                    </div>
    
                    <div  class="container container2 colorblack">
                        <div class="footer">Email ini dikirimkan kepada Anda untuk keperluan verifikasi akun yang baru saja Anda daftarkan.
                        </div>
                    </div>
                </div>
            </body>
        </html>
        ');

        if ($this->email->send()) {
            $this->set_response([
                   'status' => true,
                   'code' => 200,
                   'mymessage' => 'Email pemberitahuan telah dikirim ke email Anda, silahkan cek inbox email Anda!',
                    ], REST_Controller::HTTP_OK);
        } else {
            $this->set_response([
                   'status' => false,
                   'code' => 404,
                   'mymessage' => 'Gagal mengirimkan email verifikasi!',
                    ], REST_Controller::HTTP_NOT_FOUND);
        }
    }
}
