/**
 * CodeGym Career Landing Page - JavaScript Functionality
 * Framework: Bootstrap Material Design (MDBootstrap 4.19.1)
 */

$(document).ready(function () {
  // 1. Khoi tao hieu ung MDBootstrap Waves
  Waves.attach('.btn:not(.btn-flat), .btn-floating', ['waves-light']);
  Waves.init();

  // 2. Xu ly thanh Navbar khi cuon trang
  const navbar = $('.code-navbar');
  const backToTopBtn = $('#btn-back-to-top');

  $(window).on('scroll', function () {
    const scrollPos = $(this).scrollTop();

    // Do bong khi cuon
    if (scrollPos > 50) {
      navbar.addClass('scrolled');
    } else {
      navbar.removeClass('scrolled');
    }

    // Hien / an nut Back To Top
    if (scrollPos > 350) {
      backToTopBtn.css('display', 'flex').fadeIn(200);
    } else {
      backToTopBtn.fadeOut(200);
    }
  });

  // Nut Back to Top
  backToTopBtn.on('click', function () {
    $('html, body').animate({ scrollTop: 0 }, 500);
  });

  // 3. Cuon muot ma (Smooth Scroll) cho cac lien ket dieu huong
  $('a[href^="#"]').on('click', function (e) {
    const targetId = $(this).attr('href');
    if (targetId && targetId !== '#' && $(targetId).length) {
      e.preventDefault();
      const offsetTop = $(targetId).offset().top - 70;

      $('html, body').animate(
        {
          scrollTop: offsetTop,
        },
        500
      );

      // Tu dong dong menu mobile sau khi bam
      if ($('.navbar-collapse').hasClass('show')) {
        $('.navbar-toggler').trigger('click');
      }
    }
  });

  // 4. Cap nhat Active nav link khi cuon qua cac Section (ScrollSpy thu cong)
  $(window).on('scroll', function () {
    const scrollPos = $(document).scrollTop() + 100;
    $('section[id]').each(function () {
      const top = $(this).offset().top;
      const bottom = top + $(this).outerHeight();
      const id = $(this).attr('id');

      if (scrollPos >= top && scrollPos <= bottom) {
        $('.code-navbar .nav-link').removeClass('active');
        $('.code-navbar .nav-link[href="#' + id + '"]').addClass('active');
      }
    });
  });

  // 5. Xu ly form dang ky tu van & tinh toan xac thuc
  $('#admissionForm').on('submit', function (e) {
    e.preventDefault();

    const fullName = $('#formName').val().trim();
    const phone = $('#formPhone').val().trim();
    const email = $('#formEmail').val().trim();
    const city = $('#formCity').val().trim();
    const targetGroup = $('#formRole').val();
    const captcha = $('#formCaptcha').val().trim();

    const alertBox = $('#formAlert');

    // Kiem tra cac truong bat buoc
    if (!fullName || !phone || !email || !city || !targetGroup) {
      alertBox
        .removeClass('d-none alert-success')
        .addClass('alert-danger')
        .html(
          '<i class="fas fa-exclamation-circle mr-2"></i>Vui lòng điền đầy đủ tất cả các trường thông tin bắt buộc.'
        );
      return;
    }

    // Kiem tra dinh dang so dien thoai don gian
    const phoneRegex = /^[0-9+ ]{9,13}$/;
    if (!phoneRegex.test(phone)) {
      alertBox
        .removeClass('d-none alert-success')
        .addClass('alert-danger')
        .html(
          '<i class="fas fa-exclamation-circle mr-2"></i>Số điện thoại không hợp lệ. Vui lòng nhập từ 9 đến 12 số.'
        );
      return;
    }

    // Kiem tra cau hoi bao mat 15 + 7 = 22
    if (captcha !== '22') {
      alertBox
        .removeClass('d-none alert-success')
        .addClass('alert-danger')
        .html(
          '<i class="fas fa-times-circle mr-2"></i>Câu hỏi xác thực chưa đúng (15 + 7 = 22). Vui lòng thử lại.'
        );
      return;
    }

    // Neu hop le: hien thi thong bao thanh cong
    alertBox
      .removeClass('d-none alert-danger')
      .addClass('alert-success')
      .html(
        '<i class="fas fa-check-circle mr-2"></i><strong>Đăng ký thành công!</strong> Cố vấn tuyển sinh CodeGym sẽ liên hệ với bạn trong vòng 24 giờ.'
      );

    // Reset form
    $('#admissionForm')[0].reset();
  });
});
