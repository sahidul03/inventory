// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks


// BEGIN BASE JS
//= require pace.min.js

//= require jquery-1.9.1.min.js
//= require jquery-migrate-1.1.0.min.js
//= require jquery-ui.min.js
//= require bootstrap.min.js
//= require jquery.slimscroll.min.js
//= require jquery.cookie.js
// END BASE JS


// BEGIN PAGE LEVEL JS
//= require jquery.plugin.js
//= require chart.js
//= require chart-js.demo.min


//= require jquery.fileupload.js
//= require jquery.blueimp-gallery.min.js
//= require jquery.fileupload-audio.js
//= require jquery.fileupload-image.js
//= require jquery.fileupload-process.js
//= require jquery.fileupload-ui.js
//= require jquery.fileupload-video.js
//= require jquery.iframe-transport.js
//= require jquery.fileupload-validate.js


//= require jquery.gritter.js
//= require jquery.flot.min.js
//= require jquery.flot.time.min.js
//= require jquery.flot.resize.min.js
//= require jquery.flot.pie.min.js
//= require jquery.sparkline.js
//= require jquery-jvectormap-1.2.2.min.js
//= require jquery-jvectormap-world-mill-en.js
//= require bootstrap-datepicker.js
//= require pace.min.js
//= require dashboard.min
//= require jquery.dataTables.js
//= require dataTables.tableTools.js
//= require switchery.min
//= require powerange.min
//= require form-slider-switcher.demo.min
//= require table-manage-tabletools.demo.min
//= require form-plugins.demo.min
//= require apps.min
// END PAGE LEVEL JS
//= require jquery.jcrop


////////////////////////            Info message automatically slide up                //////////////////////
setTimeout(function(){
    $( ".alert-info").add('.alert-warning').slideUp(1000,function(){
        $(this).alert('close');
    });
},10000);


