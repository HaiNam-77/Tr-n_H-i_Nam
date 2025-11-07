% --- 1. Thiết kế bộ lọc Chebyshev loại 1 ---
clear; clc; close all;

fs = 7000;
kp = 0.4; % Độ gợn dải thông (dB)
ks = 50;  % Độ suy giảm dải chặn (dB)
fp = [1400, 2100]; % Dải thông (Hz)
fs_band = [1050, 2450]; % Dải chặn (Hz)

% Chuẩn hóa tần số
fn = fs / 2;
Wp = fp / fn;
Ws = fs_band / fn;

% Tính toán và thiết kế
[n, Wc] = cheb1ord(Wp, Ws, kp, ks);
[b, a] = cheby1(n, kp, Wc, 'bandpass');

% --- 2. Vẽ Đồ thị 1 (Đáp ứng tần số) ---
figure; % Mở Figure 1
freqz(b, a, 1024, fs);
grid on;
title('Đáp ứng tần số - Bộ lọc Thông Dải Chebyshev loại 1');

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
title('Tín hiệu đã lọc (Qua bộ lọc Chebyshev loại 1)');
xlabel('Thời gian (s)');
ylabel('Biên độ');
grid on;
