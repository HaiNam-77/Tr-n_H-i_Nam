% 1. Định nghĩa thông số kỹ thuật của bộ lọc
wp = [0.2 0.7];     % Tần số chuẩn hóa của dải thông (Passband)
ws = [0.1 0.8];     % Tần số chuẩn hóa của dải chặn (Stopband)
rp = 3;             % Độ gợn sóng tối đa trong dải thông (dB)
rs = 40;            % Độ suy giảm tối thiểu trong dải chặn (dB)

% 2. Tìm bậc và tần số cắt tối ưu cho bộ lọc
[n, wn] = buttord(wp, ws, rp, rs);

% 3. Thiết kế bộ lọc Butterworth với bậc và tần số cắt đã tìm được
% 'wn' là vector 2-phần-tử, 'butter' tự động hiểu là 'bandpass'
[b, a] = butter(n, wn);

% 4. (Tùy chọn) Vẽ đáp ứng tần số của bộ lọc
freqz(b, a, 1024);
grid on;
title('Đáp ứng tần số - Bộ lọc Thông Dải Butterworth');

