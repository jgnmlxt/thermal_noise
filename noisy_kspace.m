dimension=100;
repetition=50;
GT=phantom("Modified Shepp-Logan",dimension);
k_GT=fft2(GT);

kspaces=add_gaussian_noise(k_GT,0.5,repetition);


% dim(X)=repetition*resolution
arranged_GT_noise=reshape(kspaces,repetition,[]);
images=zeros(repetition,dimension,dimension);
for i=1:repetition
    kspace=squeeze(kspaces(i,:,:));
    images(i,:,:)=ifft2(kspace);
end
images_arranged=reshape(images,repetition,[]);
figure;
imshow(squeeze(images(1,:,:)));

%% 

mean=sum(images_arranged,2)/dimension^2;
shifted_arranged_GT_noise=images_arranged-mean;

C=images_arranged*images_arranged'/(dimension^2);
[evector,evalue]=eig(C);


[~,index]=max(diag(evalue));
u_principal=evector(:,index);

temp=u_principal'*shifted_arranged_GT_noise;
recon=u_principal*temp;

figure;
recon=recon+mean;
recon1=squeeze(recon(1,:));
recon=reshape(recon1,dimension,dimension);
imshow(real(recon));
title("First image after recon with the principle component");

MSE=(sum((real(recon)-real(GT)).^2,"all")/(dimension^2))^(1/2);
disp(MSE);
MSE=(sum(((recon)-(GT)).^2,"all")/(dimension^2))^(1/2);
disp(MSE);
MSE=real((sum(((recon)-(GT)).^2,"all")/(dimension^2))^(1/2));
disp(MSE);

GT_shape=zeros(1,dimension,dimension);
GT_shape(1,:,:)=GT;
offsets=images-GT_shape;
sum_offsets=sum(offsets,"all")

sum(images(1,:,:)-GT_shape,"all")