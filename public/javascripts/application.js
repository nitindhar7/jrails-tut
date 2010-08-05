$(document).ready(function() {
  color_rows();
});

function color_rows() {
  $("#stores .store:even").css('background', '#EFEFEF');
  $("#stores .store:odd").css('background', '#FFF');
}
