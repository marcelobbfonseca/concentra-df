$('.mf').click(function(){
  $('.choice__id').html($(this).children('.mf__id').html());
  $('.choice__name').html($(this).children('.mf__name').html());
  $('.choice__price').html($(this).children('.mf__price').html());
});