function freqs = Freq(d)
    freqs = zeros(0);
    for i = 1:3,
        freqs(i) = sqrt(d(i,i));
    end;
end