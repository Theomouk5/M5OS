void main(void)
{
    *((unsigned char*) 0xb8000) = 'Y';
    *((unsigned char*) 0xb8001) = 0x0f;
    *((unsigned char*) 0xb8002) = 'o';
    *((unsigned char*) 0xb8003) = 0x0f;
}
