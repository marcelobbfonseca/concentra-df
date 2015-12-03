$('.send-choice').click(function(){
  $.ajax({
    method: 'POST',
    url: "/vaga",
    data: {vacancy: {modality_filiation_id: $('.mf--active .mf__id').html()}},
    success: function(data){
      $('.subscription__choice').addClass('subscription__choice--hidden');
      console.log(data['waiting_list']);
      if(data['waiting_list']){
        $('.subscription__waiting-list').addClass('subscription__waiting-list--active');
      }
      else{
        $('.subscription__vacancy').addClass('subscription__vacancy--active');
      };
    },
    error: function(){
      $('.subscription__error').addClass('subscription__error--active');
    }
  });
});