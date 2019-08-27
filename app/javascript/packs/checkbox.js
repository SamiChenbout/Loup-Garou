const mycheck = () => {
  $('input[type=checkbox]').on('change', function (e) {
    if ($('input[type=checkbox]:checked').length > 2) {
        $(this).prop('checked', false);
        alert("allowed only 2");
    }
  });
};

export { mycheck };
