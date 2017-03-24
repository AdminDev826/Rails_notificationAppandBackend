$(document).ready(function() {
    $(".perk-pseudo-modal-link").click(function() {
    $(".perk-modal").removeClass("hidden");
    });
});

$(document).ready(function() {
    $('.perk-modal-close').click(function() {
    $(".perk-modal").addClass('hidden');
    });
});
