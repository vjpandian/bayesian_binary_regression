Age = [21 22 23 24 25 26 27 28  30 31 33 34 36 37 38 39 42 51]';
Age=(Age-32)/100;
total = [14 12 27 27 2 22 25 1 64 75 33 28 59 20 33 6 43 15]';
success = [6 3 10 8 1 6 6 1 15 16 8 4 15 5 8 3 10 1]';
logitp = @(b,x) exp(b(1)+b(2).*x)./(1+exp(b(1)+b(2).*x));
prior1 = @(b1) normpdf(b1,0,50); 
prior2 = @(b2) normpdf(b2,0,50);  
post = @(b) prod(binopdf(success,total,logitp(b,Age))) * prior1(b(1)) * prior2(b(2));   
b1 = linspace(-2.0, -1, 100);
b2 = linspace(3, 5.0, 100);
simpost = zeros(100,100);
for i = 1:length(b1)
for j = 1:length(b2)
simpost(i,j) = post([b1(i), b2(j)]);
    end;
end;
mesh(b2,b1,simpost)
xlabel('Slope')
ylabel('Intercept')
zlabel('Posterior density')

view(-110,30)

initial = [1 1];
nsamples = 1000;
trace = slicesample(initial,nsamples,'pdf',post,'width',[20 2]);
figure(2)
subplot(2,1,1)
plot(trace(:,1))
ylabel('Intercept');
subplot(2,1,2)
plot(trace(:,2))
ylabel('Slope');
xlabel('Sample Number');
