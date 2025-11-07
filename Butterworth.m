% --- 1. Thiết kế bộ lọc Butterworth Thông Dải ---
clear; clc; close all;

wp = [0.2 0.7];    % Tần số chuẩn hóa của dải thông
ws = [0.1 0.8];    % Tần số chuẩn hóa của dải chặn
rp = 3;            % Độ gợn dải thông (dB)
rs = 40;           % Độ suy giảm dải chặn (dB)

% Tìm bậc và tần số cắt
[n, wn] = buttord(wp, ws, rp, rs);
% Thiết kế bộ lọc
[b, a] = butter(n, wn);

% --- 2. Vẽ Đồ thị 1 (Đáp ứng tần số) ---
figure; % Mở Figure 1
freqz(b, a, 1024);
grid on;
title('Đáp ứng tần số - Bộ lọc Thông Dải Butterworth');

% --- 3. Áp dụng lọc vào tín hiệu Chirp ---
fs = 1000; % Giả định một tần số lấy mẫu
t = 0:1/fs:1;
f0 = 0; % Tần số bắt đầu (tương ứng Wn=0)
f1 = fs/2; % Tần số kết thúc (tương ứng Wn=1)
x = chirp(t, f0, 1, f1);

% Áp dụng bộ lọc
y = filter(b, a, x);

% --- 4. Vẽ Đồ thị 2 (Lọc tín hiệu) ---
figure; % Mở Figure 2

subplot(2, 1, 1);
plot(t, x);
title('Tín hiệu Chirp đầu vào (Tần số chuẩn hóa tăng 0 -> 1)');
xlabel('Thời gian (s)');
ylabel('Biên độ');
ylim([-1 1]);

subplot(2, 1, 2);
plot(t, y);
title('Tín hiệu đã lọc (Qua bộ lọc Butterworth)');
xlabel('Thời gian (s)');
ylabel('Biên độ');
grid on;
ylim([-1 1]);
