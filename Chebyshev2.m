% --- 1. Thiết kế bộ lọc Chebyshev loại 2 ---
clear; clc; close all;

fs = 7000;
kp = 0.4; % Chú ý: cheby2 dùng 'ks' (suy hao dải chặn)
ks = 50;  % 'kp' (gợn dải thông) chỉ dùng cho cheb2ord
fp1=1400; fp2=2100;
fs1=1050; fs2=2450;

% Chuẩn hóa tần số
wp1=fp1/(fs/2); wp2=fp2/(fs/2);
ws1=fs1/(fs/2); ws2=fs2/(fs/2);

% Tính toán bậc
[n, wc] = cheb2ord([wp1 wp2], [ws1 ws2], kp, ks);
% Thiết kế bộ lọc (dùng ks)
[b, a] = cheby2(n, ks, wc, 'bandpass');

% --- 2. Vẽ Đồ thị 1 (Đáp ứng tần số) ---
figure; % Mở Figure 1
freqz(b, a, 1000, fs);
grid on;
title('Đáp ứng tần số - Bộ lọc Thông Dải Chebyshev loại 2');

% --- 3. Áp dụng lọc vào tín hiệu Chirp ---
t = 0:1/fs:1; % Thời gian từ 0 đến 1 giây
f0 = 0; % Tần số bắt đầu (0 Hz)
f1 = fs/2; % Tần số kết thúc (3500 Hz)
x = chirp(t, f0, 1, f1);

% Áp dụng bộ lọc
y = filter(b, a, x);

% --- 4. Vẽ Đồ thị 2 (Lọc tín hiệu) ---
figure; % Mở Figure 2

subplot(2, 1, 1);
plot(t, x);
title('Tín hiệu Chirp đầu vào (Tần số tăng 0 -> 3500 Hz)');
xlabel('Thời gian (s)');
ylabel('Biên độ');
ylim([-1 1]);

subplot(2, 1, 2);
plot(t, y);
title('Tín hiệu đã lọc (Qua bộ lọc Chebyshev loại 2)');
xlabel('Thời gian (s)');
ylabel('Biên độ');
grid on;
