void kernel_main(){

    //points directly at VGA memory
    //volatile cuz we dont want compiler to optimize it
    volatile char* video = (volatile char*)0xB8000;

    const char* text = "Hello from Kernel!";

    int i = 0;
    while(text[i]!='\0'){
        //writing charcter and color in VGA
        video[i*2] = text[i];
        video[i*2+1] = 0x0F;
        i++;
    }
    while(1){

    }
}