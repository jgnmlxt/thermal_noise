function GT_noise=add_gaussian_noise(GT,sigma,repetition)
    
    [rows,cols]=size(GT);
    GT_noise=zeros(repetition,rows,cols);

    for i=1:repetition
        noise_real=sigma*randn(size(GT));
        noise_complex=sigma*randn(size(GT));
    
        GT_noise(i,:,:)=GT+noise_real+1j*noise_complex;
    end
end