void k_main(void)
{
    *((unsigned char*) 0xB8000) = ':';
    *((unsigned char*) 0xB8001) = 0x0B;
    *((unsigned char*) 0xB8002) = ')';
    *((unsigned char*) 0xB8003) = 0x0B;
}
