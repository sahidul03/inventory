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
//= require plugins/pace/pace.min

//= require plugins/jquery/jquery-1.9.1.min
//= require plugins/jquery/jquery-migrate-1.1.0.min
//= require plugins/jquery-ui/ui/minified/jquery-ui.min
//= require plugins/bootstrap/js/bootstrap.min
//= require plugins/slimscroll/jquery.slimscroll.min
//= require plugins/jquery-cookie/jquery.cookie
// END BASE JS


// BEGIN PAGE LEVEL JS
//= require plugins/jquery.countdown/jquery.plugin
//= require plugins/chart-js/chart
//= require chart-js.demo.min


//= require plugins/jquery-file-upload/js/jquery.fileupload
//= require plugins/jquery-file-upload/blueimp-gallery/jquery.blueimp-gallery.min
//= require plugins/jquery-file-upload/js/jquery.fileupload-audio
//= require plugins/jquery-file-upload/js/jquery.fileupload-image
//= require plugins/jquery-file-upload/js/jquery.fileupload-process
//= require plugins/jquery-file-upload/js/jquery.fileupload-ui
//= require plugins/jquery-file-upload/js/jquery.fileupload-video
//= require plugins/jquery-file-upload/js/jquery.iframe-transport
//= require plugins/jquery-file-upload/js/jquery.fileupload-validate


//= require plugins/gritter/js/jquery.gritter
//= require plugins/flot/jquery.flot.min
//= require plugins/flot/jquery.flot.time.min
//= require plugins/flot/jquery.flot.resize.min
//= require plugins/flot/jquery.flot.pie.min
//= require plugins/sparkline/jquery.sparkline
//= require plugins/jquery-jvectormap/jquery-jvectormap-1.2.2.min
//= require plugins/jquery-jvectormap/jquery-jvectormap-world-mill-en
//= require plugins/bootstrap-datepicker/js/bootstrap-datepicker
//= require plugins/pace/pace.min
//= require dashboard.min
//= require plugins/DataTables/js/jquery.dataTables
//= require plugins/DataTables/js/dataTables.tableTools
//= require plugins/switchery/switchery.min
//= require plugins/powerange/powerange.min
//= require form-slider-switcher.demo.min
//= require table-manage-tabletools.demo.min
//= require apps.min
// END PAGE LEVEL JS

//= require_tree .


////////////////////////            Info message automatically slide up                //////////////////////
setTimeout(function(){
    $( ".alert-info").add('.alert-warning').slideUp(1000,function(){
        $(this).alert('close');
    });
},10000);


