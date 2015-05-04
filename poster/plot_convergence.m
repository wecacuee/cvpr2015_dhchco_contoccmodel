filelist = {'results/mcmc_inference_cputime.txt', ...
    'results/coordinateDescent_cputime.txt'};
colors = 'rgb';
for i=1:numel(filelist)
    data = dlmread(filelist{i});
    plot(data(:, 1), data(:, 2), colors(i));
    hold on;
end
legend('MCMC', 'Coordinate Descent');
xlabel('CPU time');
ylabel('Energy');
