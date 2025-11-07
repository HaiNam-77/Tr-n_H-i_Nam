fs=7000; kp=0.4;
ks=50; fp1=1400;
fp2=2100;
fs1=1050;
fs2=2450;

% Chuẩn hóa tần số
wp1=fp1/(fs/2);
wp2=fp2/(fs/2);
ws1=fs1/(fs/2);
ws2=fs2/(fs/2);

% Tính toán thứ tự cho bộ lọc Cheby loại 2
[n,wc]=cheb2ord([wp1 wp2], [ws1 ws2], kp, ks);

% Thiết kế bộ lọc Chebyshev loại 2 (sử dụng ks)
[b,a]=cheby2(n, ks, wc, 'bandpass');

% Vẽ
freqz(b,a,1000,fs);
grid on;
title('Đáp ứng tần số - Bộ lọc Chebyshev Loại 2');
