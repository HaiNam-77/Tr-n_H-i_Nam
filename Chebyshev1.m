clear; clc; close all;

% Tham số thiết kế
fs = 7000;
kp = 0.4;
ks = 50;
fp = [1400, 2100]; % Gộp fp1, fp2
fs_band = [1050, 2450]; % Gộp fs1, fs2 (đổi tên để tránh trùng fs)

% Chuẩn hóa tần số
fn = fs / 2;
Wp = fp / fn;
Ws = fs_band / fn;

% Tính toán và thiết kế
[n, Wc] = cheb1ord(Wp, Ws, kp, ks);
[b, a] = cheby1(n, kp, Wc, 'bandpass');

% Vẽ kết quả
figure;
freqz(b, a, 1024, fs);
grid on;
title('Đáp ứng tần số - Bộ lọc Thông Dải Chebyshev loại 1');
