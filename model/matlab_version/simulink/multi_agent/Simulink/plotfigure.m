figure
subplot(2,1,1)
plot(q1.time,q1.data(:,1));hold on
plot(q1.time,q2.data(:,1));hold on
plot(q1.time,q3.data(:,1));hold on
plot(q1.time,q4.data(:,1));

subplot(2,1,2)
plot(q1.time,q1.data(:,2));hold on
plot(q1.time,q2.data(:,2));hold on
plot(q1.time,q3.data(:,2));hold on
plot(q1.time,q4.data(:,2));