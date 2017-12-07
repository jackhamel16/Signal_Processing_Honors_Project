L = 1000;
n = 0:1:L-1;
r1 = sin(0.6535.*n); r2 = sin(0.5906.*n); r3 = sin(0.5346.*n);
r4 = sin(0.7217.*n); 
c1 = sin(0.9273.*n); c2 = sin(1.0247.*n); c3 = sin(1.1328.*n);
d0 = r4 + c2; d1 = r3 + c1; d2 = r3 + c2; d3 = r3 + c3; d4 = r2 + c1;
d5 = r2 + c2; d6 = r2 + c3; d7 = r1 + c1; d8 = r1 + c2; d9 = r1 + c3;

N = 2048;
k = 0:2047;
omega = 2*pi.*k./N;

d2_ft1 = fft(d2,N);
d9_ft1 = fft(d9,N);

subplot(1,2,1)
plot(omega(1:N/2),abs(d2_ft1(1:N/2))*2/L)
ylim([0 1.1])
title('FT: Dial Tone 2'); ylabel('|F(\omega)|'); xlabel('\omega_k')
subplot(1,2,2)
plot(omega(1:N/2),abs(d9_ft1(1:N/2))*2/L)
ylim([0 1.1])
title('FT: Dial Tone 9'); ylabel('|F(\omega)|'); xlabel('\omega_k');

space = zeros(1,1000);
phone = [d8 space d7 space d7 space d5 space d2 space d2 space d5];
sound(phone)

touch = open('touch.mat');
x1_digits = separate_digits(touch.x1,100,1000,7);
x2_digits = separate_digits(touch.x2,100,1000,7);
x1_ft = compute_ft(x1_digits,2048);
x2_ft = compute_ft(x2_digits,2048);

d = 7;
figure
plot(omega-pi,abs(x2_ft(:,d)))
xlim([-pi,pi]); xticks([-3:0.1:3])
title(['FT: Digit ',num2str(d)]); ylabel('|F(\omega)|');xlabel('\omega_k');

display('x1 and x2 using ttdecode')
x1_phone = ttdecode(x1_ft)
x2_phone = ttdecode(x2_ft)

hardx1_digits_ft = separate2ft_digits(touch.hardx1, 2048);
hardx2_digits_ft = separate2ft_digits(touch.hardx2, 2048);
hardx1_phone = ttdecode(hardx1_digits_ft)
hardx2_phone = ttdecode(hardx2_digits_ft)