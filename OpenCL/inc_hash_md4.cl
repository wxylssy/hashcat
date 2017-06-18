
// important notes on this:
// input buf unused bytes needs to be set to zero
// input buf need to be in algorithm native byte order (md5 = LE, sha1 = BE, etc)
// input buf need to be 64 byte aligned when usin md5_update()

typedef struct md4_ctx_scalar
{
  u32  h[4];

  u32  w0[4];
  u32  w1[4];
  u32  w2[4];
  u32  w3[4];

  int  len;

} md4_ctx_scalar_t;

void md4_transform_scalar (const u32 w0[4], const u32 w1[4], const u32 w2[4], const u32 w3[4], u32 digest[4])
{
  u32 a = digest[0];
  u32 b = digest[1];
  u32 c = digest[2];
  u32 d = digest[3];

  MD4_STEP_S (MD4_Fo, a, b, c, d, w0[0], MD4C00, MD4S00);
  MD4_STEP_S (MD4_Fo, d, a, b, c, w0[1], MD4C00, MD4S01);
  MD4_STEP_S (MD4_Fo, c, d, a, b, w0[2], MD4C00, MD4S02);
  MD4_STEP_S (MD4_Fo, b, c, d, a, w0[3], MD4C00, MD4S03);
  MD4_STEP_S (MD4_Fo, a, b, c, d, w1[0], MD4C00, MD4S00);
  MD4_STEP_S (MD4_Fo, d, a, b, c, w1[1], MD4C00, MD4S01);
  MD4_STEP_S (MD4_Fo, c, d, a, b, w1[2], MD4C00, MD4S02);
  MD4_STEP_S (MD4_Fo, b, c, d, a, w1[3], MD4C00, MD4S03);
  MD4_STEP_S (MD4_Fo, a, b, c, d, w2[0], MD4C00, MD4S00);
  MD4_STEP_S (MD4_Fo, d, a, b, c, w2[1], MD4C00, MD4S01);
  MD4_STEP_S (MD4_Fo, c, d, a, b, w2[2], MD4C00, MD4S02);
  MD4_STEP_S (MD4_Fo, b, c, d, a, w2[3], MD4C00, MD4S03);
  MD4_STEP_S (MD4_Fo, a, b, c, d, w3[0], MD4C00, MD4S00);
  MD4_STEP_S (MD4_Fo, d, a, b, c, w3[1], MD4C00, MD4S01);
  MD4_STEP_S (MD4_Fo, c, d, a, b, w3[2], MD4C00, MD4S02);
  MD4_STEP_S (MD4_Fo, b, c, d, a, w3[3], MD4C00, MD4S03);

  MD4_STEP_S (MD4_Go, a, b, c, d, w0[0], MD4C01, MD4S10);
  MD4_STEP_S (MD4_Go, d, a, b, c, w1[0], MD4C01, MD4S11);
  MD4_STEP_S (MD4_Go, c, d, a, b, w2[0], MD4C01, MD4S12);
  MD4_STEP_S (MD4_Go, b, c, d, a, w3[0], MD4C01, MD4S13);
  MD4_STEP_S (MD4_Go, a, b, c, d, w0[1], MD4C01, MD4S10);
  MD4_STEP_S (MD4_Go, d, a, b, c, w1[1], MD4C01, MD4S11);
  MD4_STEP_S (MD4_Go, c, d, a, b, w2[1], MD4C01, MD4S12);
  MD4_STEP_S (MD4_Go, b, c, d, a, w3[1], MD4C01, MD4S13);
  MD4_STEP_S (MD4_Go, a, b, c, d, w0[2], MD4C01, MD4S10);
  MD4_STEP_S (MD4_Go, d, a, b, c, w1[2], MD4C01, MD4S11);
  MD4_STEP_S (MD4_Go, c, d, a, b, w2[2], MD4C01, MD4S12);
  MD4_STEP_S (MD4_Go, b, c, d, a, w3[2], MD4C01, MD4S13);
  MD4_STEP_S (MD4_Go, a, b, c, d, w0[3], MD4C01, MD4S10);
  MD4_STEP_S (MD4_Go, d, a, b, c, w1[3], MD4C01, MD4S11);
  MD4_STEP_S (MD4_Go, c, d, a, b, w2[3], MD4C01, MD4S12);
  MD4_STEP_S (MD4_Go, b, c, d, a, w3[3], MD4C01, MD4S13);

  MD4_STEP_S (MD4_H , a, b, c, d, w0[0], MD4C02, MD4S20);
  MD4_STEP_S (MD4_H , d, a, b, c, w2[0], MD4C02, MD4S21);
  MD4_STEP_S (MD4_H , c, d, a, b, w1[0], MD4C02, MD4S22);
  MD4_STEP_S (MD4_H , b, c, d, a, w3[0], MD4C02, MD4S23);
  MD4_STEP_S (MD4_H , a, b, c, d, w0[2], MD4C02, MD4S20);
  MD4_STEP_S (MD4_H , d, a, b, c, w2[2], MD4C02, MD4S21);
  MD4_STEP_S (MD4_H , c, d, a, b, w1[2], MD4C02, MD4S22);
  MD4_STEP_S (MD4_H , b, c, d, a, w3[2], MD4C02, MD4S23);
  MD4_STEP_S (MD4_H , a, b, c, d, w0[1], MD4C02, MD4S20);
  MD4_STEP_S (MD4_H , d, a, b, c, w2[1], MD4C02, MD4S21);
  MD4_STEP_S (MD4_H , c, d, a, b, w1[1], MD4C02, MD4S22);
  MD4_STEP_S (MD4_H , b, c, d, a, w3[1], MD4C02, MD4S23);
  MD4_STEP_S (MD4_H , a, b, c, d, w0[3], MD4C02, MD4S20);
  MD4_STEP_S (MD4_H , d, a, b, c, w2[3], MD4C02, MD4S21);
  MD4_STEP_S (MD4_H , c, d, a, b, w1[3], MD4C02, MD4S22);
  MD4_STEP_S (MD4_H , b, c, d, a, w3[3], MD4C02, MD4S23);

  digest[0] += a;
  digest[1] += b;
  digest[2] += c;
  digest[3] += d;
}

void md4_init_scalar (md4_ctx_scalar_t *md4_ctx)
{
  md4_ctx->h[0] = MD4M_A;
  md4_ctx->h[1] = MD4M_B;
  md4_ctx->h[2] = MD4M_C;
  md4_ctx->h[3] = MD4M_D;

  md4_ctx->w0[0] = 0;
  md4_ctx->w0[1] = 0;
  md4_ctx->w0[2] = 0;
  md4_ctx->w0[3] = 0;
  md4_ctx->w1[0] = 0;
  md4_ctx->w1[1] = 0;
  md4_ctx->w1[2] = 0;
  md4_ctx->w1[3] = 0;
  md4_ctx->w2[0] = 0;
  md4_ctx->w2[1] = 0;
  md4_ctx->w2[2] = 0;
  md4_ctx->w2[3] = 0;
  md4_ctx->w3[0] = 0;
  md4_ctx->w3[1] = 0;
  md4_ctx->w3[2] = 0;
  md4_ctx->w3[3] = 0;

  md4_ctx->len = 0;
}

void md4_update_scalar_64 (md4_ctx_scalar_t *md4_ctx, u32 w0[4], u32 w1[4], u32 w2[4], u32 w3[4], const int len)
{
  const int pos = md4_ctx->len & 0x3f;

  md4_ctx->len += len;

  if ((pos + len) < 64)
  {
    switch_buffer_by_offset_le_S (w0, w1, w2, w3, pos);

    md4_ctx->w0[0] |= w0[0];
    md4_ctx->w0[1] |= w0[1];
    md4_ctx->w0[2] |= w0[2];
    md4_ctx->w0[3] |= w0[3];
    md4_ctx->w1[0] |= w1[0];
    md4_ctx->w1[1] |= w1[1];
    md4_ctx->w1[2] |= w1[2];
    md4_ctx->w1[3] |= w1[3];
    md4_ctx->w2[0] |= w2[0];
    md4_ctx->w2[1] |= w2[1];
    md4_ctx->w2[2] |= w2[2];
    md4_ctx->w2[3] |= w2[3];
    md4_ctx->w3[0] |= w3[0];
    md4_ctx->w3[1] |= w3[1];
    md4_ctx->w3[2] |= w3[2];
    md4_ctx->w3[3] |= w3[3];
  }
  else
  {
    u32 c0[4] = { 0 };
    u32 c1[4] = { 0 };
    u32 c2[4] = { 0 };
    u32 c3[4] = { 0 };

    switch_buffer_by_offset_carry_le_S (w0, w1, w2, w3, c0, c1, c2, c3, pos);

    md4_ctx->w0[0] |= w0[0];
    md4_ctx->w0[1] |= w0[1];
    md4_ctx->w0[2] |= w0[2];
    md4_ctx->w0[3] |= w0[3];
    md4_ctx->w1[0] |= w1[0];
    md4_ctx->w1[1] |= w1[1];
    md4_ctx->w1[2] |= w1[2];
    md4_ctx->w1[3] |= w1[3];
    md4_ctx->w2[0] |= w2[0];
    md4_ctx->w2[1] |= w2[1];
    md4_ctx->w2[2] |= w2[2];
    md4_ctx->w2[3] |= w2[3];
    md4_ctx->w3[0] |= w3[0];
    md4_ctx->w3[1] |= w3[1];
    md4_ctx->w3[2] |= w3[2];
    md4_ctx->w3[3] |= w3[3];

    md4_transform_scalar (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, md4_ctx->h);

    md4_ctx->w0[0] = c0[0];
    md4_ctx->w0[1] = c0[1];
    md4_ctx->w0[2] = c0[2];
    md4_ctx->w0[3] = c0[3];
    md4_ctx->w1[0] = c1[0];
    md4_ctx->w1[1] = c1[1];
    md4_ctx->w1[2] = c1[2];
    md4_ctx->w1[3] = c1[3];
    md4_ctx->w2[0] = c2[0];
    md4_ctx->w2[1] = c2[1];
    md4_ctx->w2[2] = c2[2];
    md4_ctx->w2[3] = c2[3];
    md4_ctx->w3[0] = c3[0];
    md4_ctx->w3[1] = c3[1];
    md4_ctx->w3[2] = c3[2];
    md4_ctx->w3[3] = c3[3];
  }
}

void md4_update_scalar (md4_ctx_scalar_t *md4_ctx, const u32 *w, const int len)
{
  u32 w0[4];
  u32 w1[4];
  u32 w2[4];
  u32 w3[4];

  int i;
  int j;

  for (i = 0, j = 0; i < len - 64; i += 64, j += 16)
  {
    w0[0] = w[i +  0];
    w0[1] = w[i +  1];
    w0[2] = w[i +  2];
    w0[3] = w[i +  3];
    w1[0] = w[i +  4];
    w1[1] = w[i +  5];
    w1[2] = w[i +  6];
    w1[3] = w[i +  7];
    w2[0] = w[i +  8];
    w2[1] = w[i +  9];
    w2[2] = w[i + 10];
    w2[3] = w[i + 11];
    w3[0] = w[i + 12];
    w3[1] = w[i + 13];
    w3[2] = w[i + 14];
    w3[3] = w[i + 15];

    md4_update_scalar_64 (md4_ctx, w0, w1, w2, w3, 64);
  }

  w0[0] = w[i +  0];
  w0[1] = w[i +  1];
  w0[2] = w[i +  2];
  w0[3] = w[i +  3];
  w1[0] = w[i +  4];
  w1[1] = w[i +  5];
  w1[2] = w[i +  6];
  w1[3] = w[i +  7];
  w2[0] = w[i +  8];
  w2[1] = w[i +  9];
  w2[2] = w[i + 10];
  w2[3] = w[i + 11];
  w3[0] = w[i + 12];
  w3[1] = w[i + 13];
  w3[2] = w[i + 14];
  w3[3] = w[i + 15];

  md4_update_scalar_64 (md4_ctx, w0, w1, w2, w3, len & 0x3f);
}

void md4_update_scalar_global (md4_ctx_scalar_t *md4_ctx, const __global u32 *w, const int len)
{
  u32 w0[4];
  u32 w1[4];
  u32 w2[4];
  u32 w3[4];

  int i;
  int j;

  for (i = 0, j = 0; i < len - 64; i += 64, j += 16)
  {
    w0[0] = w[i +  0];
    w0[1] = w[i +  1];
    w0[2] = w[i +  2];
    w0[3] = w[i +  3];
    w1[0] = w[i +  4];
    w1[1] = w[i +  5];
    w1[2] = w[i +  6];
    w1[3] = w[i +  7];
    w2[0] = w[i +  8];
    w2[1] = w[i +  9];
    w2[2] = w[i + 10];
    w2[3] = w[i + 11];
    w3[0] = w[i + 12];
    w3[1] = w[i + 13];
    w3[2] = w[i + 14];
    w3[3] = w[i + 15];

    md4_update_scalar_64 (md4_ctx, w0, w1, w2, w3, 64);
  }

  w0[0] = w[i +  0];
  w0[1] = w[i +  1];
  w0[2] = w[i +  2];
  w0[3] = w[i +  3];
  w1[0] = w[i +  4];
  w1[1] = w[i +  5];
  w1[2] = w[i +  6];
  w1[3] = w[i +  7];
  w2[0] = w[i +  8];
  w2[1] = w[i +  9];
  w2[2] = w[i + 10];
  w2[3] = w[i + 11];
  w3[0] = w[i + 12];
  w3[1] = w[i + 13];
  w3[2] = w[i + 14];
  w3[3] = w[i + 15];

  md4_update_scalar_64 (md4_ctx, w0, w1, w2, w3, len & 0x3f);
}

void md4_update_scalar_global_utf16le (md4_ctx_scalar_t *md4_ctx, const __global u32 *w, const int len)
{
  u32 w0[4];
  u32 w1[4];
  u32 w2[4];
  u32 w3[4];

  int i;
  int j;

  for (i = 0, j = 0; i < len - 32; i += 32, j += 8)
  {
    w0[0] = w[i + 0];
    w0[1] = w[i + 1];
    w0[2] = w[i + 2];
    w0[3] = w[i + 3];
    w1[0] = w[i + 4];
    w1[1] = w[i + 5];
    w1[2] = w[i + 6];
    w1[3] = w[i + 7];

    make_utf16le_S (w1, w2, w3);
    make_utf16le_S (w0, w0, w1);

    md4_update_scalar_64 (md4_ctx, w0, w1, w2, w3, 64);
  }

  w0[0] = w[i + 0];
  w0[1] = w[i + 1];
  w0[2] = w[i + 2];
  w0[3] = w[i + 3];
  w1[0] = w[i + 4];
  w1[1] = w[i + 5];
  w1[2] = w[i + 6];
  w1[3] = w[i + 7];

  make_utf16le_S (w1, w2, w3);
  make_utf16le_S (w0, w0, w1);

  md4_update_scalar_64 (md4_ctx, w0, w1, w2, w3, (len * 2) & 0x3f);
}

void md4_final_scalar (md4_ctx_scalar_t *md4_ctx)
{
  const int pos = md4_ctx->len & 0x3f;

  append_0x80_4x4_S (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, pos);

  if (pos >= 56)
  {
    md4_transform_scalar (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, md4_ctx->h);

    md4_ctx->w0[0] = 0;
    md4_ctx->w0[1] = 0;
    md4_ctx->w0[2] = 0;
    md4_ctx->w0[3] = 0;
    md4_ctx->w1[0] = 0;
    md4_ctx->w1[1] = 0;
    md4_ctx->w1[2] = 0;
    md4_ctx->w1[3] = 0;
    md4_ctx->w2[0] = 0;
    md4_ctx->w2[1] = 0;
    md4_ctx->w2[2] = 0;
    md4_ctx->w2[3] = 0;
    md4_ctx->w3[0] = 0;
    md4_ctx->w3[1] = 0;
    md4_ctx->w3[2] = 0;
    md4_ctx->w3[3] = 0;
  }

  md4_ctx->w3[2] = md4_ctx->len * 8;

  md4_transform_scalar (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, md4_ctx->h);
}

void md4_optimize_max_length_scalar (md4_ctx_scalar_t *md4_ctx, const int bits)
{
  md4_ctx->len &= (1 << bits) - 1;
}

// while input buf can be a vector datatype, the length of the different elements can not

typedef struct md4_ctx_vector
{
  u32x h[4];

  u32x w0[4];
  u32x w1[4];
  u32x w2[4];
  u32x w3[4];

  int  len;

} md4_ctx_vector_t;

void md4_transform_vector (const u32x w0[4], const u32x w1[4], const u32x w2[4], const u32x w3[4], u32x digest[4])
{
  u32x a = digest[0];
  u32x b = digest[1];
  u32x c = digest[2];
  u32x d = digest[3];

  MD4_STEP (MD4_Fo, a, b, c, d, w0[0], MD4C00, MD4S00);
  MD4_STEP (MD4_Fo, d, a, b, c, w0[1], MD4C00, MD4S01);
  MD4_STEP (MD4_Fo, c, d, a, b, w0[2], MD4C00, MD4S02);
  MD4_STEP (MD4_Fo, b, c, d, a, w0[3], MD4C00, MD4S03);
  MD4_STEP (MD4_Fo, a, b, c, d, w1[0], MD4C00, MD4S00);
  MD4_STEP (MD4_Fo, d, a, b, c, w1[1], MD4C00, MD4S01);
  MD4_STEP (MD4_Fo, c, d, a, b, w1[2], MD4C00, MD4S02);
  MD4_STEP (MD4_Fo, b, c, d, a, w1[3], MD4C00, MD4S03);
  MD4_STEP (MD4_Fo, a, b, c, d, w2[0], MD4C00, MD4S00);
  MD4_STEP (MD4_Fo, d, a, b, c, w2[1], MD4C00, MD4S01);
  MD4_STEP (MD4_Fo, c, d, a, b, w2[2], MD4C00, MD4S02);
  MD4_STEP (MD4_Fo, b, c, d, a, w2[3], MD4C00, MD4S03);
  MD4_STEP (MD4_Fo, a, b, c, d, w3[0], MD4C00, MD4S00);
  MD4_STEP (MD4_Fo, d, a, b, c, w3[1], MD4C00, MD4S01);
  MD4_STEP (MD4_Fo, c, d, a, b, w3[2], MD4C00, MD4S02);
  MD4_STEP (MD4_Fo, b, c, d, a, w3[3], MD4C00, MD4S03);

  MD4_STEP (MD4_Go, a, b, c, d, w0[0], MD4C01, MD4S10);
  MD4_STEP (MD4_Go, d, a, b, c, w1[0], MD4C01, MD4S11);
  MD4_STEP (MD4_Go, c, d, a, b, w2[0], MD4C01, MD4S12);
  MD4_STEP (MD4_Go, b, c, d, a, w3[0], MD4C01, MD4S13);
  MD4_STEP (MD4_Go, a, b, c, d, w0[1], MD4C01, MD4S10);
  MD4_STEP (MD4_Go, d, a, b, c, w1[1], MD4C01, MD4S11);
  MD4_STEP (MD4_Go, c, d, a, b, w2[1], MD4C01, MD4S12);
  MD4_STEP (MD4_Go, b, c, d, a, w3[1], MD4C01, MD4S13);
  MD4_STEP (MD4_Go, a, b, c, d, w0[2], MD4C01, MD4S10);
  MD4_STEP (MD4_Go, d, a, b, c, w1[2], MD4C01, MD4S11);
  MD4_STEP (MD4_Go, c, d, a, b, w2[2], MD4C01, MD4S12);
  MD4_STEP (MD4_Go, b, c, d, a, w3[2], MD4C01, MD4S13);
  MD4_STEP (MD4_Go, a, b, c, d, w0[3], MD4C01, MD4S10);
  MD4_STEP (MD4_Go, d, a, b, c, w1[3], MD4C01, MD4S11);
  MD4_STEP (MD4_Go, c, d, a, b, w2[3], MD4C01, MD4S12);
  MD4_STEP (MD4_Go, b, c, d, a, w3[3], MD4C01, MD4S13);

  MD4_STEP (MD4_H , a, b, c, d, w0[0], MD4C02, MD4S20);
  MD4_STEP (MD4_H , d, a, b, c, w2[0], MD4C02, MD4S21);
  MD4_STEP (MD4_H , c, d, a, b, w1[0], MD4C02, MD4S22);
  MD4_STEP (MD4_H , b, c, d, a, w3[0], MD4C02, MD4S23);
  MD4_STEP (MD4_H , a, b, c, d, w0[2], MD4C02, MD4S20);
  MD4_STEP (MD4_H , d, a, b, c, w2[2], MD4C02, MD4S21);
  MD4_STEP (MD4_H , c, d, a, b, w1[2], MD4C02, MD4S22);
  MD4_STEP (MD4_H , b, c, d, a, w3[2], MD4C02, MD4S23);
  MD4_STEP (MD4_H , a, b, c, d, w0[1], MD4C02, MD4S20);
  MD4_STEP (MD4_H , d, a, b, c, w2[1], MD4C02, MD4S21);
  MD4_STEP (MD4_H , c, d, a, b, w1[1], MD4C02, MD4S22);
  MD4_STEP (MD4_H , b, c, d, a, w3[1], MD4C02, MD4S23);
  MD4_STEP (MD4_H , a, b, c, d, w0[3], MD4C02, MD4S20);
  MD4_STEP (MD4_H , d, a, b, c, w2[3], MD4C02, MD4S21);
  MD4_STEP (MD4_H , c, d, a, b, w1[3], MD4C02, MD4S22);
  MD4_STEP (MD4_H , b, c, d, a, w3[3], MD4C02, MD4S23);

  digest[0] += a;
  digest[1] += b;
  digest[2] += c;
  digest[3] += d;
}

void md4_init_vector (md4_ctx_vector_t *md4_ctx)
{
  md4_ctx->h[0] = MD4M_A;
  md4_ctx->h[1] = MD4M_B;
  md4_ctx->h[2] = MD4M_C;
  md4_ctx->h[3] = MD4M_D;

  md4_ctx->w0[0] = 0;
  md4_ctx->w0[1] = 0;
  md4_ctx->w0[2] = 0;
  md4_ctx->w0[3] = 0;
  md4_ctx->w1[0] = 0;
  md4_ctx->w1[1] = 0;
  md4_ctx->w1[2] = 0;
  md4_ctx->w1[3] = 0;
  md4_ctx->w2[0] = 0;
  md4_ctx->w2[1] = 0;
  md4_ctx->w2[2] = 0;
  md4_ctx->w2[3] = 0;
  md4_ctx->w3[0] = 0;
  md4_ctx->w3[1] = 0;
  md4_ctx->w3[2] = 0;
  md4_ctx->w3[3] = 0;

  md4_ctx->len = 0;
}

void md4_update_vector_64 (md4_ctx_vector_t *md4_ctx, u32x w0[4], u32x w1[4], u32x w2[4], u32x w3[4], const int len)
{
  const int pos = md4_ctx->len & 0x3f;

  md4_ctx->len += len;

  if ((pos + len) < 64)
  {
    switch_buffer_by_offset_le (w0, w1, w2, w3, pos);

    md4_ctx->w0[0] |= w0[0];
    md4_ctx->w0[1] |= w0[1];
    md4_ctx->w0[2] |= w0[2];
    md4_ctx->w0[3] |= w0[3];
    md4_ctx->w1[0] |= w1[0];
    md4_ctx->w1[1] |= w1[1];
    md4_ctx->w1[2] |= w1[2];
    md4_ctx->w1[3] |= w1[3];
    md4_ctx->w2[0] |= w2[0];
    md4_ctx->w2[1] |= w2[1];
    md4_ctx->w2[2] |= w2[2];
    md4_ctx->w2[3] |= w2[3];
    md4_ctx->w3[0] |= w3[0];
    md4_ctx->w3[1] |= w3[1];
    md4_ctx->w3[2] |= w3[2];
    md4_ctx->w3[3] |= w3[3];
  }
  else
  {
    u32x c0[4] = { 0 };
    u32x c1[4] = { 0 };
    u32x c2[4] = { 0 };
    u32x c3[4] = { 0 };

    switch_buffer_by_offset_carry_le (w0, w1, w2, w3, c0, c1, c2, c3, pos);

    md4_ctx->w0[0] |= w0[0];
    md4_ctx->w0[1] |= w0[1];
    md4_ctx->w0[2] |= w0[2];
    md4_ctx->w0[3] |= w0[3];
    md4_ctx->w1[0] |= w1[0];
    md4_ctx->w1[1] |= w1[1];
    md4_ctx->w1[2] |= w1[2];
    md4_ctx->w1[3] |= w1[3];
    md4_ctx->w2[0] |= w2[0];
    md4_ctx->w2[1] |= w2[1];
    md4_ctx->w2[2] |= w2[2];
    md4_ctx->w2[3] |= w2[3];
    md4_ctx->w3[0] |= w3[0];
    md4_ctx->w3[1] |= w3[1];
    md4_ctx->w3[2] |= w3[2];
    md4_ctx->w3[3] |= w3[3];

    md4_transform_vector (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, md4_ctx->h);

    md4_ctx->w0[0] = c0[0];
    md4_ctx->w0[1] = c0[1];
    md4_ctx->w0[2] = c0[2];
    md4_ctx->w0[3] = c0[3];
    md4_ctx->w1[0] = c1[0];
    md4_ctx->w1[1] = c1[1];
    md4_ctx->w1[2] = c1[2];
    md4_ctx->w1[3] = c1[3];
    md4_ctx->w2[0] = c2[0];
    md4_ctx->w2[1] = c2[1];
    md4_ctx->w2[2] = c2[2];
    md4_ctx->w2[3] = c2[3];
    md4_ctx->w3[0] = c3[0];
    md4_ctx->w3[1] = c3[1];
    md4_ctx->w3[2] = c3[2];
    md4_ctx->w3[3] = c3[3];
  }
}

void md4_update_vector (md4_ctx_vector_t *md4_ctx, const u32x *w, const int len)
{
  u32x w0[4];
  u32x w1[4];
  u32x w2[4];
  u32x w3[4];

  int i;
  int j;

  for (i = 0, j = 0; i < len - 64; i += 64, j += 16)
  {
    w0[0] = w[i +  0];
    w0[1] = w[i +  1];
    w0[2] = w[i +  2];
    w0[3] = w[i +  3];
    w1[0] = w[i +  4];
    w1[1] = w[i +  5];
    w1[2] = w[i +  6];
    w1[3] = w[i +  7];
    w2[0] = w[i +  8];
    w2[1] = w[i +  9];
    w2[2] = w[i + 10];
    w2[3] = w[i + 11];
    w3[0] = w[i + 12];
    w3[1] = w[i + 13];
    w3[2] = w[i + 14];
    w3[3] = w[i + 15];

    md4_update_vector_64 (md4_ctx, w0, w1, w2, w3, 64);
  }

  w0[0] = w[i +  0];
  w0[1] = w[i +  1];
  w0[2] = w[i +  2];
  w0[3] = w[i +  3];
  w1[0] = w[i +  4];
  w1[1] = w[i +  5];
  w1[2] = w[i +  6];
  w1[3] = w[i +  7];
  w2[0] = w[i +  8];
  w2[1] = w[i +  9];
  w2[2] = w[i + 10];
  w2[3] = w[i + 11];
  w3[0] = w[i + 12];
  w3[1] = w[i + 13];
  w3[2] = w[i + 14];
  w3[3] = w[i + 15];

  md4_update_vector_64 (md4_ctx, w0, w1, w2, w3, len & 0x3f);
}

void md4_final_vector (md4_ctx_vector_t *md4_ctx)
{
  const int pos = md4_ctx->len & 0x3f;

  append_0x80_4x4 (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, pos);

  if (pos >= 56)
  {
    md4_transform_vector (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, md4_ctx->h);

    md4_ctx->w0[0] = 0;
    md4_ctx->w0[1] = 0;
    md4_ctx->w0[2] = 0;
    md4_ctx->w0[3] = 0;
    md4_ctx->w1[0] = 0;
    md4_ctx->w1[1] = 0;
    md4_ctx->w1[2] = 0;
    md4_ctx->w1[3] = 0;
    md4_ctx->w2[0] = 0;
    md4_ctx->w2[1] = 0;
    md4_ctx->w2[2] = 0;
    md4_ctx->w2[3] = 0;
    md4_ctx->w3[0] = 0;
    md4_ctx->w3[1] = 0;
    md4_ctx->w3[2] = 0;
    md4_ctx->w3[3] = 0;
  }

  md4_ctx->w3[2] = md4_ctx->len * 8;

  md4_transform_vector (md4_ctx->w0, md4_ctx->w1, md4_ctx->w2, md4_ctx->w3, md4_ctx->h);
}

void md4_optimize_max_length_vector (md4_ctx_vector_t *md4_ctx, const int bits)
{
  md4_ctx->len &= (1 << bits) - 1;
}

