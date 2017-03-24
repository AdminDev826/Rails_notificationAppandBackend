 //$('.carrousel').slick();

 $('.carrousel').slick({
  dots: false,
  infinite: false,
  speed: 1500,
  slidesToShow: 4,
  slidesToScroll: 1,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 1,
        infinite: true,
        dots: false
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 1
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    // You can unslick at a given breakpoint now by adding:
    // settings: "unslick"
    // instead of a settings object
  ]
});

$('.filter-carrousel').slick({
  dots: false,
  arrows:true,
  infinite: false,
  autoplay: false,
  slidesToShow: 5,
  slidesToScroll: 1,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 1,
        infinite: true,
        dots: false
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 1
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    // You can unslick at a given breakpoint now by adding:
    // settings: "unslick"
    // instead of a settings object
  ]
});

$('.business-dashboard').slick({
  dots: true,
  arrows:false,
  infinite: false,
  autoplay: false,
  slidesToScroll: 1,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 1,
        infinite: true,
        dots: false
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 1
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    // You can unslick at a given breakpoint now by adding:
    // settings: "unslick"
    // instead of a settings object
  ]
});

$('.profile-card').slick({
  dots: true,
  arrows:false,
  infinite: false,
  autoplay: false,
  slidesToScroll: 1,
});

$('.causes-carrousel').slick({
  dots: false,
  arrows:true,
  infinite: false,
  autoplay: false,
  slidesToShow: 1,
  slidesToScroll: 1,
  variableWidth: true
});

$('.days-carrousel').slick({
  dots: false,
  arrows:true,
  infinite: false,
  autoplay: false,
  slidesToShow: 1,
  slidesToScroll: 1,
  variableWidth: true
});
