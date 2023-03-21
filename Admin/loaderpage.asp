<style>
            #loader-page {
                width: 100%;
                height:  100%;
                position: fixed;
                background-color:rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                z-index: 9999;
                top:0px;
            }

            #loader {
                width: 42px;
                height: 42px;
                border-right: 5px solid #0077a2;
                border-left: 5px solid rgba(150, 169, 169, 0.32);
                border-top: 5px solid rgba(169, 169, 169, 0.32);
                border-bottom: 5px solid rgba(169, 169, 169, 0.32);
                border-radius: 50%;
                opacity: .6;
                animation: spin 1s linear infinite;
            }
            .cont-loader{
                background-color:#0077a2;
                width:15%;
                border-radius:20px;
                color:white;
                font-size:15px;
                font-weight:bold;
                margin-top : 10px;

            }

            @keyframes spin {
            
                0% {
                    transform: rotate(0deg);
                }
                
                100% {
                    transform: rotate(360deg);
                }
                
            }
        </style>

        <div id="loader-page" style="display:none">
            <div class="container"id="loader" style="margin-left:50%;position:right; margin-top:18rem"></div>
            <div class="container cont-loader text-center"style="margin-left:44%;position:right; margin-top:1rem"><span> Harap Tunggu . . . </span></div>
        </div>
    <script>
        function Refresh(){
            document.getElementById("loader-page").style.display = "block";
                setTimeout(() => {
                    window.location.reload();
                    document.getElementById("loader-page").style.display = "none";
                }, 1000);
            }
    </script>