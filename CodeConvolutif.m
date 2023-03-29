clear 
clc
faclong=zeros(1,10);
erreurintermediaire=faclong;
erreurfinale=faclong;
tic;
for j=1:10
    
treillis = poly2trellis(6,[46 44 35 30 27 23 15 7 5 3]);%100110 100010 11000 10111 10011 1111 1101 111 110 101 
%treillis = poly2trellis(3,[7 6 5 4 3 2 1]);
h = hammgen(7);
gh=h(1,:);
message=gh(2:numel(gh));
codeout=convenc(message,treillis);
messagetransmis=codeout;
for i =1:floor(numel(messagetransmis)*j/10)
    if messagetransmis(round(10*i/j))==0
    messagetransmis(round(10*i/j))=1;
    elseif messagetransmis(round(10*i/j))==1
    messagetransmis(round(10*i/j))=0;
    end
end
erreurintermediaire(j)=biterr(messagetransmis,codeout);
decoded = vitdec(messagetransmis,treillis,2,'trunc','hard');
erreurfinale(j)=biterr(decoded,message);
faclong(j)=j;

end 
toc;
figure
plot(faclong,erreurfinale,'b')
hold on 
plot(faclong,erreurintermediaire,'g')
xlabel('taux d erreur x 0.10');
ylabel('Nombre d erreurs');
title('Nombre d erreur en fonction du taux d erreur L=20 & 10 bits encodés');
yline(numel(messagetransmis),'r');
legend('Erreur(s) Finale(s)','Erreurs Transmises','Nombre de bits du message transmis')