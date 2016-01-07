$('.transfer__button').click(function() {
  console.log($('.transfer__input').val());
  $.ajax({
    method: 'POST',
    url: "/transfer",
    data: {transfer: {user: $('.transfer__input').val()}},
    success: function(data){
      console.log(data);
    },
    error: function(){
      console.log('Error');
    }
  });
});