$('.send-choice').click(function(){
  $.ajax({
    method: 'POST',
    url: "/vaga",
    data: {vacancy: {modality_filiation_id: $('.choice__id').html()}},
    success: function(){
      console.log('OPAAAA');
    },
    error: function(){
      console.log('OPA');
    }
  });
});