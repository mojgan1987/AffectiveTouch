% Plot Logs
timeGen
plot(fer(:,2),fer(:,1))
fer(1:295, 3) = 0;
fer(296:1292, 3) = fer(296:1292, 2);
fer(296:1292, 3) = fer(296:1292, 1);
hold on
plot(fer(:,2),fer(:,3))
axis([0 210 0 1])
FR_Read
figure
plot(manEmo1,'DisplayName','test2','YDataSource','new');figure(gcf)
hold on
plot(new(:,2),'DisplayName','test2','YDataSource','new');figure(gcf)

timeGen
Filipa(1:473, 3) = 0;
Filipa(474:1218, 3) = Filipa(474:1218, 1);
plot(Filipa(:,2),Filipa(:,1))
hold on
plot(Filipa(:,2),Filipa(:,3))