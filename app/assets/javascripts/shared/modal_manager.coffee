window.ModalManager =
  hide_modal: () ->
    $(document).on 'closed.zf.reveal', '.reveal-overlay', ->
      $(this).remove()
      $(".datepicker").remove()
