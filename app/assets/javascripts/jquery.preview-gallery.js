(function($) {

  /*
    jQuery plugin to attach gallery preview triggers and render previews in
    gallery view

      Usage: $(selector).previewGallery();

    This plugin :
      - adds preview triggers to the gallery preview button
      - on preview click event, fetches preview content from
        'data-preview-url' data attribute value and renders it
  */


  $.fn.previewGallery = function() {

    return this.each(function() {
      var $item = $(this),
          $targetId = $($item.data('doc-id'))[0],
          $previewTarget = $($item.data('preview-target')),
          $triggerBtn, $closeBtn, $arrow, $content, $viewport, $gallery, $itemsPerRow, $itemWidth;

      init();
      attachTriggerEvents();

      function showPreview() {
        var previewUrl = $item.data('preview-url'),
            $previewArrow,
            maxLeft,
            arrowLeft;

        $previewTarget.addClass('preview').empty();

        PreviewContent.append(previewUrl, $previewTarget);

        appendPointer($previewTarget);

        $previewTarget.css('display', 'inline-block');

        $previewTarget.append($closeBtn).show();

        $triggerBtn.html('<span class="glyphicon glyphicon-chevron-down"></span> Close');

        attachPreviewEvents();

        $triggerBtn.addClass('preview-open');
      }

      function appendPointer($target) {
        $target.append($arrow);

        maxLeft = $target.width() - $arrow.width() - 1,
        arrowLeft = parseInt($item.position().left + ($item.width()/2) - 20);

        if (arrowLeft < 0) arrowLeft = 0;
        if (arrowLeft > maxLeft) arrowLeft = maxLeft;

        $arrow.css('left', arrowLeft);
      }


      function attachTriggerEvents() {
        $item.find($triggerBtn).on('click', $.proxy(function(e) {
          if (previewOpen()){
            closePreview();
          }else{
            showPreview();
          }
        }, this));

        $("#documents").on('click', $.proxy(function(e) {
          if (!currentPreview(e)){
              closePreview();
          }

        }, this));
      }

      function currentPreview(e){
        if (e.target === $triggerBtn[0]){
          return true;
        }else{
          return false;
        }
      }

      function previewOpen(){
        if ($triggerBtn.hasClass('preview-open')){
          return true;
        }else{
          return false;
        }
      }



      function attachPreviewEvents() {
        $previewTarget.find($closeBtn).on('click', $.proxy(function() {
          closePreview();
        }, this));
      }

      function closePreview() {
        $previewTarget.removeClass('preview');
        $triggerBtn.removeClass('preview-open');
        $previewTarget.hide();
        $triggerBtn.html('<span class="glyphicon glyphicon-chevron-right"></span> Preview');
      }

      function itemsPerRow() {
        var width = $('#documents').width();
        return  Math.floor(width/$itemWidth);
      }

      function reorderPreviewDivs() {
        var previewDivs = $('.preview-container');
        var previewIndex = previewDivs.index($previewTarget) + 1;
        $itemsPerRow = itemsPerRow();
        if (previewIndex % $itemsPerRow !== 0){
          while (previewIndex % $itemsPerRow !== 0){
            previewIndex++;
          }
          if (previewIndex > previewDivs.length){
            previewIndex = previewDivs.length;
          }
          var detachedPreview = $previewTarget.detach();
          $($gallery[(previewIndex-1)]).after($previewTarget);
        }
      }


      function init() {
        $itemWidth = $item.outerWidth() + 10;
        $triggerBtn = $item.find('*[data-behavior="preview-button-trigger"]');//$('<div/>').addClass('preview-trigger-btn preview-opacity').html('<span class="glyphicon glyphicon-chevron-down small">');
        $closeBtn = $('<a class="preview-close"><span class="glyphicon glyphicon-remove"></span></a>');
        $arrow = $('<div class="preview-arrow"></div>');
        $gallery = $('.gallery-document');
        reorderPreviewDivs();
      }

    });

  };

})(jQuery);


Blacklight.onLoad(function() {
  $('*[data-behavior="preview-gallery"]').previewGallery();
});
