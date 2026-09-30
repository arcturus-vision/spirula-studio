#pragma once

#include "generated/slang.cuh"

struct DiffPair_float_0
{
    float primal_0;
    float differential_0;
};

inline __device__ void _d_max_0(DiffPair_float_0 * dpx_0, DiffPair_float_0 * dpy_0, float dOut_0)
{
    DiffPair_float_0 _S1 = *dpx_0;
    float _S2;
    if(((*dpx_0).primal_0) > ((*dpy_0).primal_0))
    {
        _S2 = dOut_0;
    }
    else
    {
        if(((*dpx_0).primal_0) < ((*dpy_0).primal_0))
        {
            _S2 = 0.0f;
        }
        else
        {
            _S2 = 0.5f * dOut_0;
        }
    }
    dpx_0->primal_0 = _S1.primal_0;
    dpx_0->differential_0 = _S2;
    DiffPair_float_0 _S3 = *dpy_0;
    if(((*dpy_0).primal_0) > (_S1.primal_0))
    {
        _S2 = dOut_0;
    }
    else
    {
        if(((*dpy_0).primal_0) < ((*dpx_0).primal_0))
        {
            _S2 = 0.0f;
        }
        else
        {
            _S2 = 0.5f * dOut_0;
        }
    }
    dpy_0->primal_0 = _S3.primal_0;
    dpy_0->differential_0 = _S2;
    return;
}

inline __device__ float rendered_depth_to_expected_depth(float depth_0, float transmittance_0)
{
    return depth_0 / (F32_max((1.0f - transmittance_0), (1.00000001335143196e-10f)));
}

inline __device__ void s_bwd_prop_rendered_depth_to_expected_depth_0(DiffPair_float_0 * dpdepth_0, DiffPair_float_0 * dptransmittance_0, float _s_dOut_0)
{
    float _S4 = 1.0f - (*dptransmittance_0).primal_0;
    float _S5 = (F32_max((_S4), (1.00000001335143196e-10f)));
    float _S6 = _s_dOut_0 / (_S5 * _S5);
    float _S7 = (*dpdepth_0).primal_0 * - _S6;
    float _S8 = _S5 * _S6;
    DiffPair_float_0 _S9;
    (&_S9)->primal_0 = _S4;
    (&_S9)->differential_0 = 0.0f;
    DiffPair_float_0 _S10;
    (&_S10)->primal_0 = 1.00000001335143196e-10f;
    (&_S10)->differential_0 = 0.0f;
    _d_max_0(&_S9, &_S10, _S7);
    float _S11 = - _S9.differential_0;
    dptransmittance_0->primal_0 = (*dptransmittance_0).primal_0;
    dptransmittance_0->differential_0 = _S11;
    dpdepth_0->primal_0 = (*dpdepth_0).primal_0;
    dpdepth_0->differential_0 = _S8;
    return;
}

inline __device__ void s_bwd_rendered_depth_to_expected_depth_0(DiffPair_float_0 * _S12, DiffPair_float_0 * _S13, float _S14)
{
    s_bwd_prop_rendered_depth_to_expected_depth_0(_S12, _S13, _S14);
    return;
}

inline __device__ void rendered_depth_to_expected_depth_bwd(float depth_1, float transmittance_1, float v_out_depth_0, float * v_depth_0, float * v_transmittance_0)
{
    DiffPair_float_0 p_depth_0;
    (&p_depth_0)->primal_0 = depth_1;
    (&p_depth_0)->differential_0 = 0.0f;
    DiffPair_float_0 p_transmittance_0;
    (&p_transmittance_0)->primal_0 = transmittance_1;
    (&p_transmittance_0)->differential_0 = 0.0f;
    s_bwd_rendered_depth_to_expected_depth_0(&p_depth_0, &p_transmittance_0, v_out_depth_0);
    *v_depth_0 = p_depth_0.differential_0;
    *v_transmittance_0 = p_transmittance_0.differential_0;
    return;
}

struct DiffPair_vectorx3Cfloatx2C3x3E_0
{
    float3  primal_0;
    float3  differential_0;
};

inline __device__ void _d_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpy_1, float dOut_1)
{
    float3  x_d_result_0;
    *&((&x_d_result_0)->x) = (*dpy_1).primal_0.x * dOut_1;
    float3  y_d_result_0;
    *&((&y_d_result_0)->x) = (*dpx_1).primal_0.x * dOut_1;
    *&((&x_d_result_0)->y) = (*dpy_1).primal_0.y * dOut_1;
    *&((&y_d_result_0)->y) = (*dpx_1).primal_0.y * dOut_1;
    *&((&x_d_result_0)->z) = (*dpy_1).primal_0.z * dOut_1;
    *&((&y_d_result_0)->z) = (*dpx_1).primal_0.z * dOut_1;
    dpx_1->primal_0 = (*dpx_1).primal_0;
    dpx_1->differential_0 = x_d_result_0;
    dpy_1->primal_0 = (*dpy_1).primal_0;
    dpy_1->differential_0 = y_d_result_0;
    return;
}

struct DiffPair_vectorx3Cfloatx2C2x3E_0
{
    float2  primal_0;
    float2  differential_0;
};

inline __device__ DiffPair_float_0 _d_dot_1(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_2, DiffPair_vectorx3Cfloatx2C2x3E_0 * dpy_2)
{
    DiffPair_float_0 _S15 = { *&((&dpx_2->primal_0)->x) * *&((&dpy_2->primal_0)->x) + *&((&dpx_2->primal_0)->y) * *&((&dpy_2->primal_0)->y), *&((&dpx_2->primal_0)->x) * *&((&dpy_2->differential_0)->x) + *&((&dpy_2->primal_0)->x) * *&((&dpx_2->differential_0)->x) + *&((&dpx_2->primal_0)->y) * *&((&dpy_2->differential_0)->y) + *&((&dpy_2->primal_0)->y) * *&((&dpx_2->differential_0)->y) };
    return _S15;
}

inline __device__ float dot_0(float3  x_0, float3  y_0)
{
    int i_0 = int(0);
    float result_0 = 0.0f;
    for(;;)
    {
        if(i_0 < int(3))
        {
        }
        else
        {
            break;
        }
        float result_1 = result_0 + _slang_vector_get_element(x_0, i_0) * _slang_vector_get_element(y_0, i_0);
        i_0 = i_0 + int(1);
        result_0 = result_1;
    }
    return result_0;
}

inline __device__ float dot_1(float2  x_1, float2  y_1)
{
    int i_1 = int(0);
    float result_2 = 0.0f;
    for(;;)
    {
        if(i_1 < int(2))
        {
        }
        else
        {
            break;
        }
        float result_3 = result_2 + _slang_vector_get_element(x_1, i_1) * _slang_vector_get_element(y_1, i_1);
        i_1 = i_1 + int(1);
        result_2 = result_3;
    }
    return result_2;
}

inline __device__ void blend_background_bwd_impl_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dp_rgb_0, DiffPair_float_0 * dp_transmittance_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dp_background_0, float3  v_out_0)
{
    DiffPair_float_0 _S16 = *dp_transmittance_0;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S17 = *dp_background_0;
    dp_rgb_0->primal_0 = (*dp_rgb_0).primal_0;
    dp_rgb_0->differential_0 = v_out_0;
    float _S18 = dot_0(_S17.primal_0, v_out_0);
    dp_transmittance_0->primal_0 = _S16.primal_0;
    dp_transmittance_0->differential_0 = _S18;
    float3  _S19 = make_float3 (_S16.primal_0) * v_out_0;
    dp_background_0->primal_0 = _S17.primal_0;
    dp_background_0->differential_0 = _S19;
    return;
}

inline __device__ float3  blend_background(float3  rgb_0, float transmittance_2, float3  background_0)
{
    return rgb_0 + make_float3 (transmittance_2) * background_0;
}

inline __device__ float3  min_0(float3  x_2, float3  y_2)
{
    float3  result_4;
    int i_2 = int(0);
    for(;;)
    {
        if(i_2 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_4, i_2) = (F32_min((_slang_vector_get_element(x_2, i_2)), (_slang_vector_get_element(y_2, i_2))));
        i_2 = i_2 + int(1);
    }
    return result_4;
}

inline __device__ float3  max_0(float3  x_3, float3  y_3)
{
    float3  result_5;
    int i_3 = int(0);
    for(;;)
    {
        if(i_3 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_5, i_3) = (F32_max((_slang_vector_get_element(x_3, i_3)), (_slang_vector_get_element(y_3, i_3))));
        i_3 = i_3 + int(1);
    }
    return result_5;
}

inline __device__ float3  overexposure_grad(float3  c_0, float scale_0)
{
    float3  _S20 = make_float3 (0.0f);
    return make_float3 (scale_0) * (min_0(c_0, _S20) + max_0(c_0 - make_float3 (1.0f), _S20));
}

inline __device__ void blend_background_bwd(float3  rgb_1, float transmittance_3, float3  background_1, float3  v_out_rgb_0, float overexposure_scale_0, float3  * v_rgb_0, float * v_transmittance_1, float3  * v_background_0)
{
    float3  _S21;
    if(overexposure_scale_0 != 0.0f)
    {
        _S21 = v_out_rgb_0 + overexposure_grad(rgb_1 + make_float3 (transmittance_3) * background_1, overexposure_scale_0);
    }
    else
    {
        _S21 = v_out_rgb_0;
    }
    float3  _S22 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 p_rgb_0;
    (&p_rgb_0)->primal_0 = rgb_1;
    (&p_rgb_0)->differential_0 = _S22;
    DiffPair_float_0 p_transmittance_1;
    (&p_transmittance_1)->primal_0 = transmittance_3;
    (&p_transmittance_1)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 p_background_0;
    (&p_background_0)->primal_0 = background_1;
    (&p_background_0)->differential_0 = _S22;
    blend_background_bwd_impl_0(&p_rgb_0, &p_transmittance_1, &p_background_0, _S21);
    *v_rgb_0 = p_rgb_0.differential_0;
    *v_transmittance_1 = p_transmittance_1.differential_0;
    *v_background_0 = p_background_0.differential_0;
    return;
}

inline __device__ void _d_pow_0(DiffPair_float_0 * dpx_3, DiffPair_float_0 * dpy_3, float dOut_2)
{
    if(((*dpx_3).primal_0) < 9.99999997475242708e-07f)
    {
        dpx_3->primal_0 = (*dpx_3).primal_0;
        dpx_3->differential_0 = 0.0f;
        dpy_3->primal_0 = (*dpy_3).primal_0;
        dpy_3->differential_0 = 0.0f;
    }
    else
    {
        float val_0 = (F32_pow(((*dpx_3).primal_0), ((*dpy_3).primal_0)));
        DiffPair_float_0 _S23 = *dpx_3;
        float _S24 = val_0 * (*dpy_3).primal_0 / (*dpx_3).primal_0 * dOut_2;
        dpx_3->primal_0 = (*dpx_3).primal_0;
        dpx_3->differential_0 = _S24;
        float _S25 = val_0 * (F32_log((_S23.primal_0))) * dOut_2;
        dpy_3->primal_0 = (*dpy_3).primal_0;
        dpy_3->differential_0 = _S25;
    }
    return;
}

inline __device__ DiffPair_float_0 _d_pow_1(DiffPair_float_0 * dpx_4, DiffPair_float_0 * dpy_4)
{
    float _S26 = dpx_4->primal_0;
    if((dpx_4->primal_0) < 9.99999997475242708e-07f)
    {
        DiffPair_float_0 _S27 = { 0.0f, 0.0f };
        return _S27;
    }
    float val_1 = (F32_pow((_S26), (dpy_4->primal_0)));
    DiffPair_float_0 _S28 = { val_1, val_1 * (F32_log((_S26))) * dpy_4->differential_0 + val_1 * dpy_4->primal_0 / _S26 * dpx_4->differential_0 };
    return _S28;
}

inline __device__ float linear_rgb_to_srgb(float x_4)
{
    float _S29;
    if(x_4 < 0.00313080009073019f)
    {
        _S29 = x_4 * 12.92000007629394531f;
    }
    else
    {
        _S29 = 1.0549999475479126f * (F32_pow((x_4), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    return _S29;
}

inline __device__ float linear_rgb_to_srgb_grad(float x_5)
{
    float _S30;
    if(x_5 < 0.00313080009073019f)
    {
        _S30 = 12.92000007629394531f;
    }
    else
    {
        DiffPair_float_0 _S31;
        (&_S31)->primal_0 = x_5;
        (&_S31)->differential_0 = 1.0f;
        DiffPair_float_0 _S32;
        (&_S32)->primal_0 = 0.4166666567325592f;
        (&_S32)->differential_0 = 0.0f;
        DiffPair_float_0 _S33 = _d_pow_1(&_S31, &_S32);
        _S30 = _S33.differential_0 * 1.0549999475479126f;
    }
    return _S30;
}

inline __device__ float srgb_to_linear_rgb(float x_6)
{
    float _S34;
    if(x_6 < 0.04044999927282333f)
    {
        _S34 = x_6 * 0.07739938050508499f;
    }
    else
    {
        _S34 = (F32_pow((0.94786733388900757f * (x_6 + 0.05499999970197678f)), (2.40000009536743164f)));
    }
    return _S34;
}

inline __device__ float srgb_to_linear_rgb_grad(float x_7)
{
    float _S35;
    if(x_7 < 0.04044999927282333f)
    {
        _S35 = 0.07739938050508499f;
    }
    else
    {
        DiffPair_float_0 _S36;
        (&_S36)->primal_0 = 0.94786733388900757f * (x_7 + 0.05499999970197678f);
        (&_S36)->differential_0 = 0.94786733388900757f;
        DiffPair_float_0 _S37;
        (&_S37)->primal_0 = 2.40000009536743164f;
        (&_S37)->differential_0 = 0.0f;
        DiffPair_float_0 _S38 = _d_pow_1(&_S36, &_S37);
        _S35 = _S38.differential_0;
    }
    return _S35;
}

inline __device__ float splat_dc_encode(float dc_0)
{
    return 2.0f * (F32_log(((F32_max((0.564189612865448f * dc_0 + 1.0f), (9.999999960041972e-13f))))));
}

inline __device__ float splat_dc_decode(float x_8)
{
    return ((F32_exp((0.5f * x_8))) - 1.0f) * 1.77245378494262695f;
}

struct DiffPair_matrixx3Cfloatx2C3x2C3x3E_0
{
    Matrix<float, 3, 3>  primal_0;
    Matrix<float, 3, 3>  differential_0;
};

inline __device__ void _d_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * right_0, float3  dOut_3)
{
    float _S39 = (*left_0).primal_0.rows[int(0)].x * dOut_3.x;
    Matrix<float, 3, 3>  left_d_result_0;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = (*right_0).primal_0.x * dOut_3.x;
    float sum_0 = _S39 + (*left_0).primal_0.rows[int(1)].x * dOut_3.y;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = (*right_0).primal_0.x * dOut_3.y;
    float sum_1 = sum_0 + (*left_0).primal_0.rows[int(2)].x * dOut_3.z;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = (*right_0).primal_0.x * dOut_3.z;
    float3  right_d_result_0;
    *&((&right_d_result_0)->x) = sum_1;
    float _S40 = (*left_0).primal_0.rows[int(0)].y * dOut_3.x;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = (*right_0).primal_0.y * dOut_3.x;
    float sum_2 = _S40 + (*left_0).primal_0.rows[int(1)].y * dOut_3.y;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = (*right_0).primal_0.y * dOut_3.y;
    float sum_3 = sum_2 + (*left_0).primal_0.rows[int(2)].y * dOut_3.z;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = (*right_0).primal_0.y * dOut_3.z;
    *&((&right_d_result_0)->y) = sum_3;
    float _S41 = (*left_0).primal_0.rows[int(0)].z * dOut_3.x;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = (*right_0).primal_0.z * dOut_3.x;
    float sum_4 = _S41 + (*left_0).primal_0.rows[int(1)].z * dOut_3.y;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = (*right_0).primal_0.z * dOut_3.y;
    float sum_5 = sum_4 + (*left_0).primal_0.rows[int(2)].z * dOut_3.z;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = (*right_0).primal_0.z * dOut_3.z;
    *&((&right_d_result_0)->z) = sum_5;
    left_0->primal_0 = (*left_0).primal_0;
    left_0->differential_0 = left_d_result_0;
    right_0->primal_0 = (*right_0).primal_0;
    right_0->differential_0 = right_d_result_0;
    return;
}

inline __device__ float3  mul_0(Matrix<float, 3, 3>  left_1, float3  right_1)
{
    float3  result_6;
    int i_4 = int(0);
    for(;;)
    {
        if(i_4 < int(3))
        {
        }
        else
        {
            break;
        }
        int j_0 = int(0);
        float sum_6 = 0.0f;
        for(;;)
        {
            if(j_0 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_7 = sum_6 + _slang_vector_get_element(left_1.rows[i_4], j_0) * _slang_vector_get_element(right_1, j_0);
            j_0 = j_0 + int(1);
            sum_6 = sum_7;
        }
        *_slang_vector_get_element_ptr(&result_6, i_4) = sum_6;
        i_4 = i_4 + int(1);
    }
    return result_6;
}

inline __device__ void xfer_pass_grad_0(DiffPair_float_0 * dp_0, float v_out_1)
{
    dp_0->primal_0 = (*dp_0).primal_0;
    dp_0->differential_0 = v_out_1;
    return;
}

inline __device__ float xfer_max0_0(float x_9)
{
    return (F32_max((x_9), (0.0f)));
}

inline __device__ float xfer_filmic_0(float x_10)
{
    float t_0 = xfer_max0_0(x_10 - 0.00400000018998981f);
    float _S42 = 6.19999980926513672f * t_0;
    return t_0 * (_S42 + 0.5f) / (t_0 * (_S42 + 1.70000004768371582f) + 0.05999999865889549f);
}

inline __device__ float xfer_aces_0(float x_11)
{
    return x_11 * (2.50999999046325684f * x_11 + 0.02999999932944775f) / (x_11 * (2.43000006675720215f * x_11 + 0.5899999737739563f) + 0.14000000059604645f);
}

inline __device__ float clamp_0(float x_12, float minBound_0, float maxBound_0)
{
    return (F32_min(((F32_max((x_12), (minBound_0)))), (maxBound_0)));
}

inline __device__ float xfer_clamp01_0(float x_13)
{
    return clamp_0(x_13, 0.0f, 1.0f);
}

inline __device__ float xfer_hable_0(float x_14)
{
    float _S43 = 0.15000000596046448f * x_14;
    return (x_14 * (_S43 + 0.05000000074505806f) + 0.00400000018998981f) / (x_14 * (_S43 + 0.5f) + 0.06000000238418579f) - 0.06666666269302368f;
}

inline __device__ float xfer_uncharted2_0(float x_15)
{
    return xfer_hable_0(xfer_max0_0(x_15)) / xfer_hable_0(11.19999980926513672f);
}

inline __device__ float tone_encode_0(float x_16, int transfer_0)
{
    if(transfer_0 == int(3))
    {
        return xfer_filmic_0(x_16);
    }
    float _S44;
    if(transfer_0 == int(2))
    {
        float _S45 = xfer_clamp01_0(xfer_aces_0(xfer_max0_0(x_16)));
        if(_S45 < 0.00313080009073019f)
        {
            _S44 = _S45 * 12.92000007629394531f;
        }
        else
        {
            _S44 = 1.0549999475479126f * (F32_pow((_S45), (0.4166666567325592f))) - 0.05499999970197678f;
        }
        return _S44;
    }
    if(transfer_0 == int(4))
    {
        float _S46 = xfer_clamp01_0(xfer_uncharted2_0(x_16));
        if(_S46 < 0.00313080009073019f)
        {
            _S44 = _S46 * 12.92000007629394531f;
        }
        else
        {
            _S44 = 1.0549999475479126f * (F32_pow((_S46), (0.4166666567325592f))) - 0.05499999970197678f;
        }
        return _S44;
    }
    if(transfer_0 == int(1))
    {
        float _S47 = xfer_clamp01_0(x_16);
        if(_S47 < 0.00313080009073019f)
        {
            _S44 = _S47 * 12.92000007629394531f;
        }
        else
        {
            _S44 = 1.0549999475479126f * (F32_pow((_S47), (0.4166666567325592f))) - 0.05499999970197678f;
        }
        return _S44;
    }
    float _S48 = xfer_max0_0(x_16);
    if(_S48 < 0.00313080009073019f)
    {
        _S44 = _S48 * 12.92000007629394531f;
    }
    else
    {
        _S44 = 1.0549999475479126f * (F32_pow((_S48), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    return _S44;
}

inline __device__ float3  working_to_display(float3  rgb_2, Matrix<float, 3, 3>  color_matrix_0, int transfer_1, bool is_linear_0)
{
    float3  _S49;
    if(!is_linear_0)
    {
        float _S50 = rgb_2.x;
        float _S51;
        if(_S50 < 0.04044999927282333f)
        {
            _S51 = _S50 * 0.07739938050508499f;
        }
        else
        {
            _S51 = (F32_pow((0.94786733388900757f * (_S50 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        float _S52 = rgb_2.y;
        float _S53;
        if(_S52 < 0.04044999927282333f)
        {
            _S53 = _S52 * 0.07739938050508499f;
        }
        else
        {
            _S53 = (F32_pow((0.94786733388900757f * (_S52 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        float _S54 = rgb_2.z;
        float _S55;
        if(_S54 < 0.04044999927282333f)
        {
            _S55 = _S54 * 0.07739938050508499f;
        }
        else
        {
            _S55 = (F32_pow((0.94786733388900757f * (_S54 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        _S49 = make_float3 (_S51, _S53, _S55);
    }
    else
    {
        _S49 = rgb_2;
    }
    float3  _S56 = mul_0(color_matrix_0, _S49);
    return make_float3 (tone_encode_0(_S56.x, transfer_1), tone_encode_0(_S56.y, transfer_1), tone_encode_0(_S56.z, transfer_1));
}

inline __device__ float s_primal_ctx_pow_0(float _S57, float _S58)
{
    return (F32_pow((_S57), (_S58)));
}

inline __device__ float3  s_primal_ctx_mul_0(Matrix<float, 3, 3>  _S59, float3  _S60)
{
    return mul_0(_S59, _S60);
}

inline __device__ float s_primal_ctx_xfer_max0_0(float _S61)
{
    return xfer_max0_0(_S61);
}

inline __device__ float s_primal_ctx_xfer_aces_0(float dpx_5)
{
    return dpx_5 * (2.50999999046325684f * dpx_5 + 0.02999999932944775f) / (dpx_5 * (2.43000006675720215f * dpx_5 + 0.5899999737739563f) + 0.14000000059604645f);
}

inline __device__ float s_primal_ctx_xfer_clamp01_0(float _S62)
{
    return xfer_clamp01_0(_S62);
}

inline __device__ float s_primal_ctx_xfer_hable_0(float dpx_6)
{
    float _S63 = 0.15000000596046448f * dpx_6;
    return (dpx_6 * (_S63 + 0.05000000074505806f) + 0.00400000018998981f) / (dpx_6 * (_S63 + 0.5f) + 0.06000000238418579f) - 0.06666666269302368f;
}

inline __device__ float s_primal_ctx_xfer_uncharted2_0(float dpx_7)
{
    return s_primal_ctx_xfer_hable_0(s_primal_ctx_xfer_max0_0(dpx_7)) / s_primal_ctx_xfer_hable_0(11.19999980926513672f);
}

inline __device__ void s_bwd_prop_pow_0(DiffPair_float_0 * _S64, DiffPair_float_0 * _S65, float _S66)
{
    _d_pow_0(_S64, _S65, _S66);
    return;
}

inline __device__ void s_bwd_prop_xfer_max0_0(DiffPair_float_0 * _S67, float _S68)
{
    xfer_pass_grad_0(_S67, _S68);
    return;
}

inline __device__ void s_bwd_prop_xfer_clamp01_0(DiffPair_float_0 * _S69, float _S70)
{
    xfer_pass_grad_0(_S69, _S70);
    return;
}

inline __device__ void s_bwd_prop_xfer_hable_0(DiffPair_float_0 * dpx_8, float _s_dOut_1)
{
    float _S71 = 0.15000000596046448f * (*dpx_8).primal_0;
    float _S72 = _S71 + 0.05000000074505806f;
    float _S73 = _S71 + 0.5f;
    float _S74 = (*dpx_8).primal_0 * _S73 + 0.06000000238418579f;
    float _S75 = _s_dOut_1 / (_S74 * _S74);
    float _S76 = ((*dpx_8).primal_0 * _S72 + 0.00400000018998981f) * - _S75;
    float _S77 = _S74 * _S75;
    float _S78 = _S73 * _S76 + _S72 * _S77 + 0.15000000596046448f * ((*dpx_8).primal_0 * _S76 + (*dpx_8).primal_0 * _S77);
    dpx_8->primal_0 = (*dpx_8).primal_0;
    dpx_8->differential_0 = _S78;
    return;
}

inline __device__ void s_bwd_prop_xfer_uncharted2_0(DiffPair_float_0 * dpx_9, float _s_dOut_2)
{
    float _S79 = s_primal_ctx_xfer_hable_0(11.19999980926513672f);
    float _S80 = _S79 * (_s_dOut_2 / (_S79 * _S79));
    DiffPair_float_0 _S81;
    (&_S81)->primal_0 = s_primal_ctx_xfer_max0_0((*dpx_9).primal_0);
    (&_S81)->differential_0 = 0.0f;
    s_bwd_prop_xfer_hable_0(&_S81, _S80);
    DiffPair_float_0 _S82;
    (&_S82)->primal_0 = (*dpx_9).primal_0;
    (&_S82)->differential_0 = 0.0f;
    s_bwd_prop_xfer_max0_0(&_S82, _S81.differential_0);
    dpx_9->primal_0 = (*dpx_9).primal_0;
    dpx_9->differential_0 = _S82.differential_0;
    return;
}

inline __device__ void s_bwd_prop_xfer_aces_0(DiffPair_float_0 * dpx_10, float _s_dOut_3)
{
    float _S83 = 2.50999999046325684f * (*dpx_10).primal_0 + 0.02999999932944775f;
    float _S84 = 2.43000006675720215f * (*dpx_10).primal_0 + 0.5899999737739563f;
    float _S85 = (*dpx_10).primal_0 * _S84 + 0.14000000059604645f;
    float _S86 = _s_dOut_3 / (_S85 * _S85);
    float _S87 = (*dpx_10).primal_0 * _S83 * - _S86;
    float _S88 = _S85 * _S86;
    float _S89 = _S84 * _S87 + 2.43000006675720215f * ((*dpx_10).primal_0 * _S87) + _S83 * _S88 + 2.50999999046325684f * ((*dpx_10).primal_0 * _S88);
    dpx_10->primal_0 = (*dpx_10).primal_0;
    dpx_10->differential_0 = _S89;
    return;
}

inline __device__ void s_bwd_prop_xfer_filmic_0(DiffPair_float_0 * dpx_11, float _s_dOut_4)
{
    float _S90 = (*dpx_11).primal_0 - 0.00400000018998981f;
    float _S91 = s_primal_ctx_xfer_max0_0(_S90);
    float _S92 = 6.19999980926513672f * _S91;
    float _S93 = _S92 + 0.5f;
    float _S94 = _S92 + 1.70000004768371582f;
    float _S95 = _S91 * _S94 + 0.05999999865889549f;
    float _S96 = _s_dOut_4 / (_S95 * _S95);
    float _S97 = _S91 * _S93 * - _S96;
    float _S98 = _S95 * _S96;
    float _S99 = _S94 * _S97 + _S93 * _S98 + 6.19999980926513672f * (_S91 * _S97 + _S91 * _S98);
    DiffPair_float_0 _S100;
    (&_S100)->primal_0 = _S90;
    (&_S100)->differential_0 = 0.0f;
    s_bwd_prop_xfer_max0_0(&_S100, _S99);
    dpx_11->primal_0 = (*dpx_11).primal_0;
    dpx_11->differential_0 = _S100.differential_0;
    return;
}

inline __device__ void s_bwd_prop_tone_encode_0(DiffPair_float_0 * dpx_12, int transfer_2, float _s_dOut_5)
{
    DiffPair_float_0 _S101 = *dpx_12;
    bool _S102 = transfer_2 == int(3);
    bool _S103 = !_S102;
    bool _runFlag_0;
    bool _runFlag_1;
    bool _runFlag_2;
    bool _S104;
    bool _S105;
    bool _S106;
    float _S107;
    float _S108;
    float _S109;
    float _S110;
    float _S111;
    float _S112;
    float _S113;
    if(_S103)
    {
        bool _S114 = transfer_2 == int(2);
        if(_S114)
        {
            float _S115 = s_primal_ctx_xfer_max0_0(_S101.primal_0);
            float _S116 = s_primal_ctx_xfer_aces_0(_S115);
            float _S117 = s_primal_ctx_xfer_clamp01_0(_S116);
            _runFlag_0 = false;
            _S107 = _S117;
            _S108 = _S116;
            _S109 = _S115;
        }
        else
        {
            _runFlag_0 = _S103;
            _S107 = 0.0f;
            _S108 = 0.0f;
            _S109 = 0.0f;
        }
        if(_runFlag_0)
        {
            bool _S118 = transfer_2 == int(4);
            if(_S118)
            {
                float _S119 = s_primal_ctx_xfer_uncharted2_0(_S101.primal_0);
                float _S120 = s_primal_ctx_xfer_clamp01_0(_S119);
                _runFlag_1 = false;
                _S110 = _S120;
                _S111 = _S119;
            }
            else
            {
                _runFlag_1 = _runFlag_0;
                _S110 = 0.0f;
                _S111 = 0.0f;
            }
            if(_runFlag_1)
            {
                bool _S121 = transfer_2 == int(1);
                if(_S121)
                {
                    float _S122 = s_primal_ctx_xfer_clamp01_0(_S101.primal_0);
                    _runFlag_2 = false;
                    _S112 = _S122;
                }
                else
                {
                    _runFlag_2 = _runFlag_1;
                    _S112 = 0.0f;
                }
                if(_runFlag_2)
                {
                    _S113 = s_primal_ctx_xfer_max0_0(_S101.primal_0);
                }
                else
                {
                    _S113 = 0.0f;
                }
                float _S123 = _S112;
                _S112 = _S113;
                _S104 = _S121;
                _S113 = _S123;
            }
            else
            {
                _runFlag_2 = false;
                _S112 = 0.0f;
                _S104 = false;
                _S113 = 0.0f;
            }
            float _S124 = _S110;
            float _S125 = _S111;
            _S110 = _S112;
            _S111 = _S113;
            _S105 = _S118;
            _S112 = _S124;
            _S113 = _S125;
        }
        else
        {
            _runFlag_1 = false;
            _runFlag_2 = false;
            _S110 = 0.0f;
            _S104 = false;
            _S111 = 0.0f;
            _S105 = false;
            _S112 = 0.0f;
            _S113 = 0.0f;
        }
        float _S126 = _S107;
        float _S127 = _S108;
        float _S128 = _S109;
        _S107 = _S110;
        _S108 = _S111;
        _S109 = _S112;
        _S110 = _S113;
        _S106 = _S114;
        _S111 = _S126;
        _S112 = _S127;
        _S113 = _S128;
    }
    else
    {
        _runFlag_0 = false;
        _runFlag_1 = false;
        _runFlag_2 = false;
        _S107 = 0.0f;
        _S104 = false;
        _S108 = 0.0f;
        _S105 = false;
        _S109 = 0.0f;
        _S110 = 0.0f;
        _S106 = false;
        _S111 = 0.0f;
        _S112 = 0.0f;
        _S113 = 0.0f;
    }
    if(_S103)
    {
        if(_runFlag_0)
        {
            if(_runFlag_1)
            {
                float _S129;
                if(_runFlag_2)
                {
                    if(_S107 < 0.00313080009073019f)
                    {
                        _S107 = 12.92000007629394531f * _s_dOut_5;
                    }
                    else
                    {
                        float _S130 = 1.0549999475479126f * _s_dOut_5;
                        DiffPair_float_0 _S131;
                        (&_S131)->primal_0 = _S107;
                        (&_S131)->differential_0 = 0.0f;
                        DiffPair_float_0 _S132;
                        (&_S132)->primal_0 = 0.4166666567325592f;
                        (&_S132)->differential_0 = 0.0f;
                        s_bwd_prop_pow_0(&_S131, &_S132, _S130);
                        _S107 = _S131.differential_0;
                    }
                    DiffPair_float_0 _S133;
                    (&_S133)->primal_0 = _S101.primal_0;
                    (&_S133)->differential_0 = 0.0f;
                    s_bwd_prop_xfer_max0_0(&_S133, _S107);
                    _S107 = 0.0f;
                    _S129 = _S133.differential_0;
                }
                else
                {
                    _S107 = _s_dOut_5;
                    _S129 = 0.0f;
                }
                if(_S104)
                {
                    if(_S108 < 0.00313080009073019f)
                    {
                        _S107 = 12.92000007629394531f * _S107;
                    }
                    else
                    {
                        float _S134 = 1.0549999475479126f * _S107;
                        DiffPair_float_0 _S135;
                        (&_S135)->primal_0 = _S108;
                        (&_S135)->differential_0 = 0.0f;
                        DiffPair_float_0 _S136;
                        (&_S136)->primal_0 = 0.4166666567325592f;
                        (&_S136)->differential_0 = 0.0f;
                        s_bwd_prop_pow_0(&_S135, &_S136, _S134);
                        _S107 = _S135.differential_0;
                    }
                    DiffPair_float_0 _S137;
                    (&_S137)->primal_0 = _S101.primal_0;
                    (&_S137)->differential_0 = 0.0f;
                    s_bwd_prop_xfer_clamp01_0(&_S137, _S107);
                    float _S138 = _S137.differential_0 + _S129;
                    _S107 = 0.0f;
                    _S108 = _S138;
                }
                else
                {
                    _S108 = _S129;
                }
            }
            else
            {
                _S107 = _s_dOut_5;
                _S108 = 0.0f;
            }
            if(_S105)
            {
                if(_S109 < 0.00313080009073019f)
                {
                    _S107 = 12.92000007629394531f * _S107;
                }
                else
                {
                    float _S139 = 1.0549999475479126f * _S107;
                    DiffPair_float_0 _S140;
                    (&_S140)->primal_0 = _S109;
                    (&_S140)->differential_0 = 0.0f;
                    DiffPair_float_0 _S141;
                    (&_S141)->primal_0 = 0.4166666567325592f;
                    (&_S141)->differential_0 = 0.0f;
                    s_bwd_prop_pow_0(&_S140, &_S141, _S139);
                    _S107 = _S140.differential_0;
                }
                DiffPair_float_0 _S142;
                (&_S142)->primal_0 = _S110;
                (&_S142)->differential_0 = 0.0f;
                s_bwd_prop_xfer_clamp01_0(&_S142, _S107);
                DiffPair_float_0 _S143;
                (&_S143)->primal_0 = _S101.primal_0;
                (&_S143)->differential_0 = 0.0f;
                s_bwd_prop_xfer_uncharted2_0(&_S143, _S142.differential_0);
                float _S144 = _S143.differential_0 + _S108;
                _S107 = 0.0f;
                _S108 = _S144;
            }
        }
        else
        {
            _S107 = _s_dOut_5;
            _S108 = 0.0f;
        }
        if(_S106)
        {
            if(_S111 < 0.00313080009073019f)
            {
                _S107 = 12.92000007629394531f * _S107;
            }
            else
            {
                float _S145 = 1.0549999475479126f * _S107;
                DiffPair_float_0 _S146;
                (&_S146)->primal_0 = _S111;
                (&_S146)->differential_0 = 0.0f;
                DiffPair_float_0 _S147;
                (&_S147)->primal_0 = 0.4166666567325592f;
                (&_S147)->differential_0 = 0.0f;
                s_bwd_prop_pow_0(&_S146, &_S147, _S145);
                _S107 = _S146.differential_0;
            }
            DiffPair_float_0 _S148;
            (&_S148)->primal_0 = _S112;
            (&_S148)->differential_0 = 0.0f;
            s_bwd_prop_xfer_clamp01_0(&_S148, _S107);
            DiffPair_float_0 _S149;
            (&_S149)->primal_0 = _S113;
            (&_S149)->differential_0 = 0.0f;
            s_bwd_prop_xfer_aces_0(&_S149, _S148.differential_0);
            DiffPair_float_0 _S150;
            (&_S150)->primal_0 = _S101.primal_0;
            (&_S150)->differential_0 = 0.0f;
            s_bwd_prop_xfer_max0_0(&_S150, _S149.differential_0);
            float _S151 = _S150.differential_0 + _S108;
            _S107 = 0.0f;
            _S108 = _S151;
        }
    }
    else
    {
        _S107 = _s_dOut_5;
        _S108 = 0.0f;
    }
    if(_S102)
    {
        DiffPair_float_0 _S152;
        (&_S152)->primal_0 = _S101.primal_0;
        (&_S152)->differential_0 = 0.0f;
        s_bwd_prop_xfer_filmic_0(&_S152, _S107);
        _S107 = _S152.differential_0 + _S108;
    }
    else
    {
        _S107 = _S108;
    }
    dpx_12->primal_0 = (*dpx_12).primal_0;
    dpx_12->differential_0 = _S107;
    return;
}

inline __device__ void s_bwd_prop_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S153, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S154, float3  _S155)
{
    _d_mul_0(_S153, _S154, _S155);
    return;
}

inline __device__ void s_bwd_prop_working_to_display_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dprgb_0, Matrix<float, 3, 3>  color_matrix_1, int transfer_3, bool is_linear_1, float3  _s_dOut_6)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S156 = *dprgb_0;
    bool _S157 = !is_linear_1;
    float _S158;
    float _S159;
    float _S160;
    float3  _S161;
    if(_S157)
    {
        float _S162 = _S156.primal_0.x;
        if(_S162 < 0.04044999927282333f)
        {
            _S158 = _S162 * 0.07739938050508499f;
        }
        else
        {
            _S158 = s_primal_ctx_pow_0(0.94786733388900757f * (_S162 + 0.05499999970197678f), 2.40000009536743164f);
        }
        float _S163 = _S156.primal_0.y;
        if(_S163 < 0.04044999927282333f)
        {
            _S159 = _S163 * 0.07739938050508499f;
        }
        else
        {
            _S159 = s_primal_ctx_pow_0(0.94786733388900757f * (_S163 + 0.05499999970197678f), 2.40000009536743164f);
        }
        float _S164 = _S156.primal_0.z;
        if(_S164 < 0.04044999927282333f)
        {
            _S160 = _S164 * 0.07739938050508499f;
        }
        else
        {
            _S160 = s_primal_ctx_pow_0(0.94786733388900757f * (_S164 + 0.05499999970197678f), 2.40000009536743164f);
        }
        _S161 = make_float3 (_S158, _S159, _S160);
        _S158 = _S164;
        _S159 = _S163;
        _S160 = _S162;
    }
    else
    {
        _S161 = _S156.primal_0;
        _S158 = 0.0f;
        _S159 = 0.0f;
        _S160 = 0.0f;
    }
    float3  _S165 = s_primal_ctx_mul_0(color_matrix_1, _S161);
    float _S166 = _S165.x;
    float _S167 = _S165.y;
    float _S168 = _S165.z;
    DiffPair_float_0 _S169;
    (&_S169)->primal_0 = _S168;
    (&_S169)->differential_0 = 0.0f;
    s_bwd_prop_tone_encode_0(&_S169, transfer_3, _s_dOut_6.z);
    DiffPair_float_0 _S170;
    (&_S170)->primal_0 = _S167;
    (&_S170)->differential_0 = 0.0f;
    s_bwd_prop_tone_encode_0(&_S170, transfer_3, _s_dOut_6.y);
    DiffPair_float_0 _S171;
    (&_S171)->primal_0 = _S166;
    (&_S171)->differential_0 = 0.0f;
    s_bwd_prop_tone_encode_0(&_S171, transfer_3, _s_dOut_6.x);
    float3  _S172 = make_float3 (_S171.differential_0, _S170.differential_0, _S169.differential_0);
    Matrix<float, 3, 3>  _S173 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S174;
    (&_S174)->primal_0 = color_matrix_1;
    (&_S174)->differential_0 = _S173;
    float3  _S175 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S176;
    (&_S176)->primal_0 = _S161;
    (&_S176)->differential_0 = _S175;
    s_bwd_prop_mul_0(&_S174, &_S176, _S172);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S177 = _S176;
    if(_S157)
    {
        bool _S178 = _S158 < 0.04044999927282333f;
        if(_S178)
        {
            _S158 = 0.0f;
        }
        else
        {
            _S158 = 0.94786733388900757f * (_S158 + 0.05499999970197678f);
        }
        if(_S178)
        {
            _S158 = 0.07739938050508499f * _S177.differential_0.z;
        }
        else
        {
            DiffPair_float_0 _S179;
            (&_S179)->primal_0 = _S158;
            (&_S179)->differential_0 = 0.0f;
            DiffPair_float_0 _S180;
            (&_S180)->primal_0 = 2.40000009536743164f;
            (&_S180)->differential_0 = 0.0f;
            s_bwd_prop_pow_0(&_S179, &_S180, _S177.differential_0.z);
            _S158 = 0.94786733388900757f * _S179.differential_0;
        }
        bool _S181 = _S159 < 0.04044999927282333f;
        if(_S181)
        {
            _S159 = 0.0f;
        }
        else
        {
            _S159 = 0.94786733388900757f * (_S159 + 0.05499999970197678f);
        }
        if(_S181)
        {
            _S159 = 0.07739938050508499f * _S177.differential_0.y;
        }
        else
        {
            DiffPair_float_0 _S182;
            (&_S182)->primal_0 = _S159;
            (&_S182)->differential_0 = 0.0f;
            DiffPair_float_0 _S183;
            (&_S183)->primal_0 = 2.40000009536743164f;
            (&_S183)->differential_0 = 0.0f;
            s_bwd_prop_pow_0(&_S182, &_S183, _S177.differential_0.y);
            _S159 = 0.94786733388900757f * _S182.differential_0;
        }
        bool _S184 = _S160 < 0.04044999927282333f;
        if(_S184)
        {
            _S160 = 0.0f;
        }
        else
        {
            _S160 = 0.94786733388900757f * (_S160 + 0.05499999970197678f);
        }
        if(_S184)
        {
            _S160 = 0.07739938050508499f * _S177.differential_0.x;
        }
        else
        {
            DiffPair_float_0 _S185;
            (&_S185)->primal_0 = _S160;
            (&_S185)->differential_0 = 0.0f;
            DiffPair_float_0 _S186;
            (&_S186)->primal_0 = 2.40000009536743164f;
            (&_S186)->differential_0 = 0.0f;
            s_bwd_prop_pow_0(&_S185, &_S186, _S177.differential_0.x);
            _S160 = 0.94786733388900757f * _S185.differential_0;
        }
        _S161 = make_float3 (_S160, _S159, _S158);
    }
    else
    {
        _S161 = _S177.differential_0;
    }
    dprgb_0->primal_0 = (*dprgb_0).primal_0;
    dprgb_0->differential_0 = _S161;
    return;
}

inline __device__ void s_bwd_working_to_display_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S187, Matrix<float, 3, 3>  _S188, int _S189, bool _S190, float3  _S191)
{
    s_bwd_prop_working_to_display_0(_S187, _S188, _S189, _S190, _S191);
    return;
}

inline __device__ float3  working_to_display_bwd(float3  rgb_3, Matrix<float, 3, 3>  color_matrix_2, int transfer_4, bool is_linear_2, float3  v_out_rgb_1)
{
    float3  _S192 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 p_rgb_1;
    (&p_rgb_1)->primal_0 = rgb_3;
    (&p_rgb_1)->differential_0 = _S192;
    s_bwd_working_to_display_0(&p_rgb_1, color_matrix_2, transfer_4, is_linear_2, v_out_rgb_1);
    return p_rgb_1.differential_0;
}

inline __device__ void _d_sqrt_0(DiffPair_float_0 * dpx_13, float dOut_4)
{
    float _S193 = 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), ((*dpx_13).primal_0)))))) * dOut_4;
    dpx_13->primal_0 = (*dpx_13).primal_0;
    dpx_13->differential_0 = _S193;
    return;
}

inline __device__ DiffPair_float_0 _d_sqrt_1(DiffPair_float_0 * dpx_14)
{
    DiffPair_float_0 _S194 = { (F32_sqrt((dpx_14->primal_0))), 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), (dpx_14->primal_0)))))) * dpx_14->differential_0 };
    return _S194;
}

inline __device__ float xfer_filmic_inv_0(float y_4)
{
    float _S195 = (F32_min((y_4), (xfer_filmic_0(11.19999980926513672f))));
    float a_0 = 6.19999980926513672f * (1.0f - _S195);
    float b_0 = 0.5f - 1.70000004768371582f * _S195;
    return (- b_0 + (F32_sqrt(((F32_max((b_0 * b_0 - 4.0f * a_0 * (-0.05999999865889549f * _S195)), (0.0f))))))) / (2.0f * a_0) + 0.00400000018998981f;
}

inline __device__ float xfer_aces_inv_0(float y_5)
{
    float a_1 = 2.50999999046325684f - 2.43000006675720215f * y_5;
    float b_1 = 0.02999999932944775f - 0.5899999737739563f * y_5;
    return (- b_1 + (F32_sqrt(((F32_max((b_1 * b_1 - 4.0f * a_1 * (-0.14000000059604645f * y_5)), (0.0f))))))) / (2.0f * a_1);
}

inline __device__ float xfer_uncharted2_inv_0(float y_6)
{
    float r_0 = y_6 * xfer_hable_0(11.19999980926513672f) + 0.06666666269302368f;
    float a_2 = 0.15000000596046448f * (1.0f - r_0);
    float b_2 = 0.5f * (0.10000000149011612f - r_0);
    return (- b_2 + (F32_sqrt(((F32_max((b_2 * b_2 - 4.0f * a_2 * (0.20000000298023224f * (0.01999999955296516f - r_0 * 0.30000001192092896f))), (0.0f))))))) / (2.0f * a_2);
}

inline __device__ float tone_decode_0(float d_0, int transfer_5)
{
    if(transfer_5 == int(3))
    {
        return xfer_filmic_inv_0(d_0);
    }
    float _S196;
    if(transfer_5 == int(2))
    {
        if(d_0 < 0.04044999927282333f)
        {
            _S196 = d_0 * 0.07739938050508499f;
        }
        else
        {
            _S196 = (F32_pow((0.94786733388900757f * (d_0 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        return xfer_aces_inv_0(_S196);
    }
    if(transfer_5 == int(4))
    {
        if(d_0 < 0.04044999927282333f)
        {
            _S196 = d_0 * 0.07739938050508499f;
        }
        else
        {
            _S196 = (F32_pow((0.94786733388900757f * (d_0 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        return xfer_uncharted2_inv_0(_S196);
    }
    if(d_0 < 0.04044999927282333f)
    {
        _S196 = d_0 * 0.07739938050508499f;
    }
    else
    {
        _S196 = (F32_pow((0.94786733388900757f * (d_0 + 0.05499999970197678f)), (2.40000009536743164f)));
    }
    return _S196;
}

inline __device__ float3  display_to_working3(float3  rgb_4, int transfer_6, bool is_linear_3)
{
    float _S197 = tone_decode_0(rgb_4.x, transfer_6);
    float _S198 = tone_decode_0(rgb_4.y, transfer_6);
    float _S199 = tone_decode_0(rgb_4.z, transfer_6);
    float3  lin_0 = make_float3 (_S197, _S198, _S199);
    if(is_linear_3)
    {
        return lin_0;
    }
    float _S200;
    if(_S197 < 0.00313080009073019f)
    {
        _S200 = _S197 * 12.92000007629394531f;
    }
    else
    {
        _S200 = 1.0549999475479126f * (F32_pow((_S197), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    float _S201;
    if(_S198 < 0.00313080009073019f)
    {
        _S201 = _S198 * 12.92000007629394531f;
    }
    else
    {
        _S201 = 1.0549999475479126f * (F32_pow((_S198), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    float _S202;
    if(_S199 < 0.00313080009073019f)
    {
        _S202 = _S199 * 12.92000007629394531f;
    }
    else
    {
        _S202 = 1.0549999475479126f * (F32_pow((_S199), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    return make_float3 (_S200, _S201, _S202);
}

inline __device__ float3  background_apply_exponent(float3  display_0, float p_0)
{
    if(p_0 == 1.0f)
    {
        return display_0;
    }
    return make_float3 ((F32_pow(((F32_max((display_0.x), (0.0f)))), (p_0))), (F32_pow(((F32_max((display_0.y), (0.0f)))), (p_0))), (F32_pow(((F32_max((display_0.z), (0.0f)))), (p_0))));
}

inline __device__ void _d_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * a_3, DiffPair_vectorx3Cfloatx2C3x3E_0 * b_3, float3  dOut_5)
{
    float _S203 = dOut_5.y;
    float _S204 = dOut_5.z;
    float _S205 = dOut_5.x;
    float _S206 = (*a_3).primal_0.z * _S203 + - (*a_3).primal_0.y * _S204;
    float _S207 = - (*a_3).primal_0.z * _S205 + (*a_3).primal_0.x * _S204;
    float _S208 = (*a_3).primal_0.y * _S205 + - (*a_3).primal_0.x * _S203;
    float3  _S209 = make_float3 (- (*b_3).primal_0.z * _S203 + (*b_3).primal_0.y * _S204, (*b_3).primal_0.z * _S205 + - (*b_3).primal_0.x * _S204, - (*b_3).primal_0.y * _S205 + (*b_3).primal_0.x * _S203);
    a_3->primal_0 = (*a_3).primal_0;
    a_3->differential_0 = _S209;
    float3  _S210 = make_float3 (_S206, _S207, _S208);
    b_3->primal_0 = (*b_3).primal_0;
    b_3->differential_0 = _S210;
    return;
}

inline __device__ float3  cross_0(float3  left_2, float3  right_2)
{
    float _S211 = left_2.y;
    float _S212 = right_2.z;
    float _S213 = left_2.z;
    float _S214 = right_2.y;
    float _S215 = right_2.x;
    float _S216 = left_2.x;
    return make_float3 (_S211 * _S212 - _S213 * _S214, _S213 * _S215 - _S216 * _S212, _S216 * _S214 - _S211 * _S215);
}

inline __device__ float length_0(float3  x_17)
{
    return (F32_sqrt((dot_0(x_17, x_17))));
}

inline __device__ float length_1(float2  x_18)
{
    return (F32_sqrt((dot_1(x_18, x_18))));
}

inline __device__ float3  points_to_normal(FixedArray<float3 , 4>  points_0)
{
    float3  _S217 = points_0[int(0)];
    bool _S218;
    if((dot_0(_S217, _S217)) == 0.0f)
    {
        _S218 = true;
    }
    else
    {
        float3  _S219 = points_0[int(1)];
        _S218 = (dot_0(_S219, _S219)) == 0.0f;
    }
    if(_S218)
    {
        _S218 = true;
    }
    else
    {
        float3  _S220 = points_0[int(2)];
        _S218 = (dot_0(_S220, _S220)) == 0.0f;
    }
    if(_S218)
    {
        _S218 = true;
    }
    else
    {
        float3  _S221 = points_0[int(3)];
        _S218 = (dot_0(_S221, _S221)) == 0.0f;
    }
    if(_S218)
    {
        return make_float3 (0.0f);
    }
    float3  normal_0 = cross_0(points_0[int(1)] - points_0[int(0)], - (points_0[int(3)] - points_0[int(2)]));
    float3  normal_1;
    if((dot_0(normal_0, normal_0)) != 0.0f)
    {
        normal_1 = normal_0 / make_float3 (length_0(normal_0));
    }
    else
    {
        normal_1 = normal_0;
    }
    return normal_1;
}

struct DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0
{
    FixedArray<float3 , 4>  primal_0;
    FixedArray<float3 , 4>  differential_0;
};

inline __device__ float s_primal_ctx_dot_0(float3  _S222, float3  _S223)
{
    return dot_0(_S222, _S223);
}

inline __device__ float3  s_primal_ctx_cross_0(float3  _S224, float3  _S225)
{
    return cross_0(_S224, _S225);
}

inline __device__ void s_bwd_prop_sqrt_0(DiffPair_float_0 * _S226, float _S227)
{
    _d_sqrt_0(_S226, _S227);
    return;
}

inline __device__ void s_bwd_prop_length_impl_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_15, float _s_dOut_7)
{
    float _S228 = (*dpx_15).primal_0.x;
    float _S229 = (*dpx_15).primal_0.y;
    float _S230 = (*dpx_15).primal_0.z;
    DiffPair_float_0 _S231;
    (&_S231)->primal_0 = _S228 * _S228 + _S229 * _S229 + _S230 * _S230;
    (&_S231)->differential_0 = 0.0f;
    s_bwd_prop_sqrt_0(&_S231, _s_dOut_7);
    float _S232 = (*dpx_15).primal_0.z * _S231.differential_0;
    float _S233 = _S232 + _S232;
    float _S234 = (*dpx_15).primal_0.y * _S231.differential_0;
    float _S235 = _S234 + _S234;
    float _S236 = (*dpx_15).primal_0.x * _S231.differential_0;
    float _S237 = _S236 + _S236;
    float3  _S238 = make_float3 (0.0f);
    *&((&_S238)->z) = _S233;
    *&((&_S238)->y) = _S235;
    *&((&_S238)->x) = _S237;
    dpx_15->primal_0 = (*dpx_15).primal_0;
    dpx_15->differential_0 = _S238;
    return;
}

inline __device__ void s_bwd_length_impl_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S239, float _S240)
{
    s_bwd_prop_length_impl_0(_S239, _S240);
    return;
}

inline __device__ void s_bwd_prop_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S241, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S242, float _S243)
{
    _d_dot_0(_S241, _S242, _S243);
    return;
}

inline __device__ void s_bwd_prop_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S244, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S245, float3  _S246)
{
    _d_cross_0(_S244, _S245, _S246);
    return;
}

inline __device__ void s_bwd_prop_points_to_normal_0(DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0 * dppoints_0, float3  _s_dOut_8)
{
    FixedArray<float3 , 4>  _S247 = dppoints_0->primal_0;
    float3  _S248 = make_float3 (0.0f);
    float3  _S249 = dppoints_0->primal_0[int(0)];
    bool _S250 = (s_primal_ctx_dot_0(_S249, _S249)) == 0.0f;
    bool _S251;
    float3  _S252;
    if(_S250)
    {
        _S251 = true;
        _S252 = _S248;
    }
    else
    {
        float3  _S253 = _S247[int(1)];
        _S251 = (s_primal_ctx_dot_0(_S253, _S253)) == 0.0f;
        _S252 = _S247[int(1)];
    }
    bool _S254;
    float3  _S255;
    if(_S251)
    {
        _S254 = true;
        _S255 = _S248;
    }
    else
    {
        float3  _S256 = _S247[int(2)];
        _S254 = (s_primal_ctx_dot_0(_S256, _S256)) == 0.0f;
        _S255 = _S247[int(2)];
    }
    bool _S257;
    float3  _S258;
    if(_S254)
    {
        _S257 = true;
        _S258 = _S248;
    }
    else
    {
        float3  _S259 = _S247[int(3)];
        _S257 = (s_primal_ctx_dot_0(_S259, _S259)) == 0.0f;
        _S258 = _S247[int(3)];
    }
    bool _S260 = !_S257;
    float3  _S261;
    float3  _S262;
    float3  _S263;
    float3  _S264;
    float3  _S265;
    if(_S260)
    {
        float3  dx_0 = _S247[int(1)] - _S247[int(0)];
        float3  _S266 = - (_S247[int(3)] - _S247[int(2)]);
        float3  _S267 = s_primal_ctx_cross_0(dx_0, _S266);
        bool _S268 = (s_primal_ctx_dot_0(_S267, _S267)) != 0.0f;
        if(_S268)
        {
            float _S269 = length_0(_S267);
            float3  _S270 = make_float3 (_S269);
            _S261 = make_float3 (_S269 * _S269);
            _S262 = _S270;
        }
        else
        {
            _S261 = _S248;
            _S262 = _S248;
        }
        float3  _S271 = _S262;
        _S257 = _S268;
        _S262 = _S267;
        _S263 = _S271;
        _S264 = dx_0;
        _S265 = _S266;
    }
    else
    {
        _S257 = false;
        _S261 = _S248;
        _S262 = _S248;
        _S263 = _S248;
        _S264 = _S248;
        _S265 = _S248;
    }
    FixedArray<float3 , 4>  _S272;
    if(_S260)
    {
        if(_S257)
        {
            float3  _S273 = _s_dOut_8 / _S261;
            float3  _S274 = _S262 * - _S273;
            float3  _S275 = _S263 * _S273;
            float _S276 = _S274.x + _S274.y + _S274.z;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S277;
            (&_S277)->primal_0 = _S262;
            (&_S277)->differential_0 = _S248;
            s_bwd_length_impl_0(&_S277, _S276);
            _S261 = _S275 + _S277.differential_0;
        }
        else
        {
            _S261 = _s_dOut_8;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S278;
        (&_S278)->primal_0 = _S262;
        (&_S278)->differential_0 = _S248;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S279;
        (&_S279)->primal_0 = _S262;
        (&_S279)->differential_0 = _S248;
        s_bwd_prop_dot_0(&_S278, &_S279, 0.0f);
        float3  _S280 = _S279.differential_0 + _S278.differential_0 + _S261;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S281;
        (&_S281)->primal_0 = _S264;
        (&_S281)->differential_0 = _S248;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S282;
        (&_S282)->primal_0 = _S265;
        (&_S282)->differential_0 = _S248;
        s_bwd_prop_cross_0(&_S281, &_S282, _S280);
        float3  s_diff_dy_T_0 = - _S282.differential_0;
        float3  _S283 = - s_diff_dy_T_0;
        float3  _S284 = - _S281.differential_0;
        FixedArray<float3 , 4>  _S285;
        _S285[int(0)] = _S248;
        _S285[int(1)] = _S248;
        _S285[int(2)] = _S248;
        _S285[int(3)] = _S248;
        _S285[int(2)] = _S283;
        _S285[int(3)] = s_diff_dy_T_0;
        _S285[int(1)] = _S281.differential_0;
        _S272[int(0)] = _S285[int(0)];
        _S272[int(1)] = _S285[int(1)];
        _S272[int(2)] = _S285[int(2)];
        _S272[int(3)] = _S285[int(3)];
        _S261 = _S284;
    }
    else
    {
        _S272[int(0)] = _S248;
        _S272[int(1)] = _S248;
        _S272[int(2)] = _S248;
        _S272[int(3)] = _S248;
        _S261 = _S248;
    }
    if(_S254)
    {
    }
    else
    {
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S286;
        (&_S286)->primal_0 = _S258;
        (&_S286)->differential_0 = _S248;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S287;
        (&_S287)->primal_0 = _S258;
        (&_S287)->differential_0 = _S248;
        s_bwd_prop_dot_0(&_S286, &_S287, 0.0f);
        float3  _S288 = _S287.differential_0 + _S286.differential_0;
        FixedArray<float3 , 4>  _S289;
        _S289[int(0)] = _S248;
        _S289[int(1)] = _S248;
        _S289[int(2)] = _S248;
        _S289[int(3)] = _S248;
        _S289[int(3)] = _S288;
        float3  _S290 = _S272[int(1)] + _S289[int(1)];
        float3  _S291 = _S272[int(2)] + _S289[int(2)];
        float3  _S292 = _S272[int(3)] + _S289[int(3)];
        _S272[int(0)] = _S272[int(0)] + _S289[int(0)];
        _S272[int(1)] = _S290;
        _S272[int(2)] = _S291;
        _S272[int(3)] = _S292;
    }
    if(_S251)
    {
    }
    else
    {
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S293;
        (&_S293)->primal_0 = _S255;
        (&_S293)->differential_0 = _S248;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S294;
        (&_S294)->primal_0 = _S255;
        (&_S294)->differential_0 = _S248;
        s_bwd_prop_dot_0(&_S293, &_S294, 0.0f);
        float3  _S295 = _S294.differential_0 + _S293.differential_0;
        FixedArray<float3 , 4>  _S296;
        _S296[int(0)] = _S248;
        _S296[int(1)] = _S248;
        _S296[int(2)] = _S248;
        _S296[int(3)] = _S248;
        _S296[int(2)] = _S295;
        float3  _S297 = _S272[int(1)] + _S296[int(1)];
        float3  _S298 = _S272[int(2)] + _S296[int(2)];
        float3  _S299 = _S272[int(3)] + _S296[int(3)];
        _S272[int(0)] = _S272[int(0)] + _S296[int(0)];
        _S272[int(1)] = _S297;
        _S272[int(2)] = _S298;
        _S272[int(3)] = _S299;
    }
    if(_S250)
    {
    }
    else
    {
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S300;
        (&_S300)->primal_0 = _S252;
        (&_S300)->differential_0 = _S248;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S301;
        (&_S301)->primal_0 = _S252;
        (&_S301)->differential_0 = _S248;
        s_bwd_prop_dot_0(&_S300, &_S301, 0.0f);
        float3  _S302 = _S301.differential_0 + _S300.differential_0;
        FixedArray<float3 , 4>  _S303;
        _S303[int(0)] = _S248;
        _S303[int(1)] = _S248;
        _S303[int(2)] = _S248;
        _S303[int(3)] = _S248;
        _S303[int(1)] = _S302;
        float3  _S304 = _S272[int(1)] + _S303[int(1)];
        float3  _S305 = _S272[int(2)] + _S303[int(2)];
        float3  _S306 = _S272[int(3)] + _S303[int(3)];
        _S272[int(0)] = _S272[int(0)] + _S303[int(0)];
        _S272[int(1)] = _S304;
        _S272[int(2)] = _S305;
        _S272[int(3)] = _S306;
    }
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S307;
    (&_S307)->primal_0 = _S247[int(0)];
    (&_S307)->differential_0 = _S248;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S308;
    (&_S308)->primal_0 = _S247[int(0)];
    (&_S308)->differential_0 = _S248;
    s_bwd_prop_dot_0(&_S307, &_S308, 0.0f);
    float3  _S309 = _S308.differential_0 + _S307.differential_0 + _S261;
    FixedArray<float3 , 4>  _S310;
    _S310[int(0)] = _S248;
    _S310[int(1)] = _S248;
    _S310[int(2)] = _S248;
    _S310[int(3)] = _S248;
    _S310[int(0)] = _S309;
    FixedArray<float3 , 4>  _S311 = {
        _S272[int(0)] + _S310[int(0)], _S272[int(1)] + _S310[int(1)], _S272[int(2)] + _S310[int(2)], _S272[int(3)] + _S310[int(3)]
    };
    dppoints_0->primal_0 = dppoints_0->primal_0;
    dppoints_0->differential_0 = _S311;
    return;
}

inline __device__ void s_bwd_points_to_normal_0(DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0 * _S312, float3  _S313)
{
    s_bwd_prop_points_to_normal_0(_S312, _S313);
    return;
}

inline __device__ void points_to_normal_vjp(FixedArray<float3 , 4>  points_1, float3  v_normal_0, FixedArray<float3 , 4>  * v_points_0)
{
    FixedArray<float3 , 4>  _S314 = { make_float3 (0.0f), make_float3 (0.0f), make_float3 (0.0f), make_float3 (0.0f) };
    DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0 dp_points_0;
    (&dp_points_0)->primal_0 = points_1;
    (&dp_points_0)->differential_0 = _S314;
    s_bwd_points_to_normal_0(&dp_points_0, v_normal_0);
    *v_points_0 = (&dp_points_0)->differential_0;
    return;
}

inline __device__ Matrix<float, 2, 2>  transpose_0(Matrix<float, 2, 2>  x_19)
{
    Matrix<float, 2, 2>  result_7;
    int r_1 = int(0);
    for(;;)
    {
        if(r_1 < int(2))
        {
        }
        else
        {
            break;
        }
        int c_1 = int(0);
        for(;;)
        {
            if(c_1 < int(2))
            {
            }
            else
            {
                break;
            }
            *_slang_vector_get_element_ptr(((&result_7)->rows + (r_1)), c_1) = _slang_vector_get_element(x_19.rows[c_1], r_1);
            c_1 = c_1 + int(1);
        }
        r_1 = r_1 + int(1);
    }
    return result_7;
}

inline __device__ float determinant_0(Matrix<float, 2, 2>  m_0)
{
    return m_0.rows[int(0)].x * m_0.rows[int(1)].y - m_0.rows[int(0)].y * m_0.rows[int(1)].x;
}

inline __device__ bool undistort_point_0(float2  uv_0, FixedArray<float, 1>  * dist_coeffs_0, int maxiter_0, float2  * uv_undist_0)
{
    *uv_undist_0 = uv_0;
    return true;
}

inline __device__ float2  DistOpenCV_distort_0(float2  uv_1, FixedArray<float, 4>  * coeffs_0)
{
    float u_0 = uv_1.x;
    float v_0 = uv_1.y;
    float r2_0 = u_0 * u_0 + v_0 * v_0;
    return uv_1 * make_float2 (1.0f + r2_0 * ((*coeffs_0)[int(0)] + r2_0 * (*coeffs_0)[int(1)])) + make_float2 (2.0f * (*coeffs_0)[int(2)] * u_0 * v_0 + (*coeffs_0)[int(3)] * (r2_0 + 2.0f * u_0 * u_0), 2.0f * (*coeffs_0)[int(3)] * u_0 * v_0 + (*coeffs_0)[int(2)] * (r2_0 + 2.0f * v_0 * v_0));
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistOpenCV_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_0, FixedArray<float, 4>  * coeffs_1)
{
    float u_1 = dpuv_0->primal_0.x;
    float s_diff_u_0 = dpuv_0->differential_0.x;
    float v_1 = dpuv_0->primal_0.y;
    float s_diff_v_0 = dpuv_0->differential_0.y;
    float _S315 = s_diff_u_0 * u_1;
    float _S316 = s_diff_v_0 * v_1;
    float r2_1 = u_1 * u_1 + v_1 * v_1;
    float s_diff_r2_0 = _S315 + _S315 + (_S316 + _S316);
    float _S317 = (*coeffs_1)[int(0)] + r2_1 * (*coeffs_1)[int(1)];
    float radial_0 = 1.0f + r2_1 * _S317;
    float _S318 = 2.0f * (*coeffs_1)[int(2)];
    float _S319 = _S318 * u_1;
    float _S320 = 2.0f * u_1;
    float _S321 = 2.0f * (*coeffs_1)[int(3)];
    float _S322 = _S321 * u_1;
    float _S323 = 2.0f * v_1;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S324 = { dpuv_0->primal_0 * make_float2 (radial_0) + make_float2 (_S319 * v_1 + (*coeffs_1)[int(3)] * (r2_1 + _S320 * u_1), _S322 * v_1 + (*coeffs_1)[int(2)] * (r2_1 + _S323 * v_1)), dpuv_0->differential_0 * make_float2 (radial_0) + make_float2 (s_diff_r2_0 * _S317 + s_diff_r2_0 * (*coeffs_1)[int(1)] * r2_1) * dpuv_0->primal_0 + make_float2 (s_diff_u_0 * _S318 * v_1 + s_diff_v_0 * _S319 + (s_diff_r2_0 + (s_diff_u_0 * 2.0f * u_1 + s_diff_u_0 * _S320)) * (*coeffs_1)[int(3)], s_diff_u_0 * _S321 * v_1 + s_diff_v_0 * _S322 + (s_diff_r2_0 + (s_diff_v_0 * 2.0f * v_1 + s_diff_v_0 * _S323)) * (*coeffs_1)[int(2)]) };
    return _S324;
}

inline __device__ bool undistort_point_1(float2  uv_2, FixedArray<float, 4>  * dist_coeffs_1, int maxiter_1, float2  * uv_undist_1)
{
    int i_5 = int(0);
    float2  q_0 = uv_2;
    for(;;)
    {
        if(i_5 < maxiter_1)
        {
        }
        else
        {
            break;
        }
        float2  _S325 = DistOpenCV_distort_0(q_0, dist_coeffs_1);
        float2  r_2 = _S325 - uv_2;
        float2  _S326 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S327;
        (&_S327)->primal_0 = q_0;
        (&_S327)->differential_0 = _S326;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S328 = s_fwd_DistOpenCV_distort_0(&_S327, dist_coeffs_1);
        float2  _S329 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S330;
        (&_S330)->primal_0 = q_0;
        (&_S330)->differential_0 = _S329;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S331 = s_fwd_DistOpenCV_distort_0(&_S330, dist_coeffs_1);
        Matrix<float, 2, 2>  _S332 = transpose_0(makeMatrix<float, 2, 2> (_S328.differential_0, _S331.differential_0));
        float inv_det_0 = 1.0f / (_S332.rows[int(0)].x * _S332.rows[int(1)].y - _S332.rows[int(0)].y * _S332.rows[int(1)].x);
        float _S333 = r_2.x;
        float _S334 = r_2.y;
        float2  q_1 = q_0 - make_float2 ((_S333 * _S332.rows[int(1)].y - _S334 * _S332.rows[int(0)].y) * inv_det_0, (- _S333 * _S332.rows[int(1)].x + _S334 * _S332.rows[int(0)].x) * inv_det_0);
        i_5 = i_5 + int(1);
        q_0 = q_1;
    }
    *uv_undist_1 = q_0;
    float2  _S335 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S336;
    (&_S336)->primal_0 = q_0;
    (&_S336)->differential_0 = _S335;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S337 = s_fwd_DistOpenCV_distort_0(&_S336, dist_coeffs_1);
    float2  _S338 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S339;
    (&_S339)->primal_0 = q_0;
    (&_S339)->differential_0 = _S338;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S340 = s_fwd_DistOpenCV_distort_0(&_S339, dist_coeffs_1);
    Matrix<float, 2, 2>  _S341 = transpose_0(makeMatrix<float, 2, 2> (_S337.differential_0, _S340.differential_0));
    float _S342 = (F32_min((determinant_0(_S341)), ((F32_min((_S341.rows[int(0)].x), (_S341.rows[int(1)].y))))));
    bool _S343;
    if(_S342 > 0.25f)
    {
        _S343 = _S342 < 4.0f;
    }
    else
    {
        _S343 = false;
    }
    if(_S343)
    {
        float2  _S344 = DistOpenCV_distort_0(q_0, dist_coeffs_1);
        _S343 = (dot_1(q_0, _S344)) >= 0.0f;
    }
    else
    {
        _S343 = false;
    }
    if(_S343)
    {
        float2  _S345 = DistOpenCV_distort_0(*uv_undist_1, dist_coeffs_1);
        _S343 = (length_1(_S345 - uv_2)) < 0.00999999977648258f;
    }
    else
    {
        _S343 = false;
    }
    return _S343;
}

inline __device__ float2  DistThinPrism_distort_0(float2  uv_3, FixedArray<float, 8>  * coeffs_2)
{
    float u_2 = uv_3.x;
    float v_2 = uv_3.y;
    float r2_2 = u_2 * u_2 + v_2 * v_2;
    return uv_3 * make_float2 (1.0f + r2_2 * ((*coeffs_2)[int(0)] + r2_2 * ((*coeffs_2)[int(1)] + r2_2 * ((*coeffs_2)[int(2)] + r2_2 * (*coeffs_2)[int(3)])))) + make_float2 (2.0f * (*coeffs_2)[int(4)] * u_2 * v_2 + (*coeffs_2)[int(5)] * (r2_2 + 2.0f * u_2 * u_2) + (*coeffs_2)[int(6)] * r2_2, 2.0f * (*coeffs_2)[int(5)] * u_2 * v_2 + (*coeffs_2)[int(4)] * (r2_2 + 2.0f * v_2 * v_2) + (*coeffs_2)[int(7)] * r2_2);
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistThinPrism_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_1, FixedArray<float, 8>  * coeffs_3)
{
    float u_3 = dpuv_1->primal_0.x;
    float s_diff_u_1 = dpuv_1->differential_0.x;
    float v_3 = dpuv_1->primal_0.y;
    float s_diff_v_1 = dpuv_1->differential_0.y;
    float _S346 = s_diff_u_1 * u_3;
    float _S347 = s_diff_v_1 * v_3;
    float r2_3 = u_3 * u_3 + v_3 * v_3;
    float s_diff_r2_1 = _S346 + _S346 + (_S347 + _S347);
    float _S348 = (*coeffs_3)[int(2)] + r2_3 * (*coeffs_3)[int(3)];
    float _S349 = (*coeffs_3)[int(1)] + r2_3 * _S348;
    float _S350 = (*coeffs_3)[int(0)] + r2_3 * _S349;
    float radial_1 = 1.0f + r2_3 * _S350;
    float _S351 = 2.0f * (*coeffs_3)[int(4)];
    float _S352 = _S351 * u_3;
    float _S353 = 2.0f * u_3;
    float _S354 = 2.0f * (*coeffs_3)[int(5)];
    float _S355 = _S354 * u_3;
    float _S356 = 2.0f * v_3;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S357 = { dpuv_1->primal_0 * make_float2 (radial_1) + make_float2 (_S352 * v_3 + (*coeffs_3)[int(5)] * (r2_3 + _S353 * u_3) + (*coeffs_3)[int(6)] * r2_3, _S355 * v_3 + (*coeffs_3)[int(4)] * (r2_3 + _S356 * v_3) + (*coeffs_3)[int(7)] * r2_3), dpuv_1->differential_0 * make_float2 (radial_1) + make_float2 (s_diff_r2_1 * _S350 + (s_diff_r2_1 * _S349 + (s_diff_r2_1 * _S348 + s_diff_r2_1 * (*coeffs_3)[int(3)] * r2_3) * r2_3) * r2_3) * dpuv_1->primal_0 + make_float2 (s_diff_u_1 * _S351 * v_3 + s_diff_v_1 * _S352 + (s_diff_r2_1 + (s_diff_u_1 * 2.0f * u_3 + s_diff_u_1 * _S353)) * (*coeffs_3)[int(5)] + s_diff_r2_1 * (*coeffs_3)[int(6)], s_diff_u_1 * _S354 * v_3 + s_diff_v_1 * _S355 + (s_diff_r2_1 + (s_diff_v_1 * 2.0f * v_3 + s_diff_v_1 * _S356)) * (*coeffs_3)[int(4)] + s_diff_r2_1 * (*coeffs_3)[int(7)]) };
    return _S357;
}

inline __device__ bool undistort_point_2(float2  uv_4, FixedArray<float, 8>  * dist_coeffs_2, int maxiter_2, float2  * uv_undist_2)
{
    int i_6 = int(0);
    float2  q_2 = uv_4;
    for(;;)
    {
        if(i_6 < maxiter_2)
        {
        }
        else
        {
            break;
        }
        float2  _S358 = DistThinPrism_distort_0(q_2, dist_coeffs_2);
        float2  r_3 = _S358 - uv_4;
        float2  _S359 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S360;
        (&_S360)->primal_0 = q_2;
        (&_S360)->differential_0 = _S359;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S361 = s_fwd_DistThinPrism_distort_0(&_S360, dist_coeffs_2);
        float2  _S362 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S363;
        (&_S363)->primal_0 = q_2;
        (&_S363)->differential_0 = _S362;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S364 = s_fwd_DistThinPrism_distort_0(&_S363, dist_coeffs_2);
        Matrix<float, 2, 2>  _S365 = transpose_0(makeMatrix<float, 2, 2> (_S361.differential_0, _S364.differential_0));
        float inv_det_1 = 1.0f / (_S365.rows[int(0)].x * _S365.rows[int(1)].y - _S365.rows[int(0)].y * _S365.rows[int(1)].x);
        float _S366 = r_3.x;
        float _S367 = r_3.y;
        float2  q_3 = q_2 - make_float2 ((_S366 * _S365.rows[int(1)].y - _S367 * _S365.rows[int(0)].y) * inv_det_1, (- _S366 * _S365.rows[int(1)].x + _S367 * _S365.rows[int(0)].x) * inv_det_1);
        i_6 = i_6 + int(1);
        q_2 = q_3;
    }
    *uv_undist_2 = q_2;
    float2  _S368 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S369;
    (&_S369)->primal_0 = q_2;
    (&_S369)->differential_0 = _S368;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S370 = s_fwd_DistThinPrism_distort_0(&_S369, dist_coeffs_2);
    float2  _S371 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S372;
    (&_S372)->primal_0 = q_2;
    (&_S372)->differential_0 = _S371;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S373 = s_fwd_DistThinPrism_distort_0(&_S372, dist_coeffs_2);
    Matrix<float, 2, 2>  _S374 = transpose_0(makeMatrix<float, 2, 2> (_S370.differential_0, _S373.differential_0));
    float _S375 = (F32_min((determinant_0(_S374)), ((F32_min((_S374.rows[int(0)].x), (_S374.rows[int(1)].y))))));
    bool _S376;
    if(_S375 > 0.25f)
    {
        _S376 = _S375 < 4.0f;
    }
    else
    {
        _S376 = false;
    }
    if(_S376)
    {
        float2  _S377 = DistThinPrism_distort_0(q_2, dist_coeffs_2);
        _S376 = (dot_1(q_2, _S377)) >= 0.0f;
    }
    else
    {
        _S376 = false;
    }
    if(_S376)
    {
        float2  _S378 = DistThinPrism_distort_0(*uv_undist_2, dist_coeffs_2);
        _S376 = (length_1(_S378 - uv_4)) < 0.00999999977648258f;
    }
    else
    {
        _S376 = false;
    }
    return _S376;
}

inline __device__ int clamp_1(int x_20, int minBound_1, int maxBound_1)
{
    return (I32_min(((I32_max((x_20), (minBound_1)))), (maxBound_1)));
}

inline __device__ float DistKBPolarSpline_cubic_0(float a_4, float b_4, float c_2, float d_1, float t_1)
{
    return b_4 + 0.5f * t_1 * (c_2 - a_4 + t_1 * (2.0f * a_4 - 5.0f * b_4 + 4.0f * c_2 - d_1 + t_1 * (3.0f * (b_4 - c_2) + d_1 - a_4)));
}

inline __device__ float2  DistKBPolarSpline_distort_0(float2  uv_5, FixedArray<float, 58>  * coeffs_4)
{
    float r2_4 = dot_1(uv_5, uv_5);
    float2  kb_0 = uv_5 * make_float2 (1.0f + r2_4 * ((*coeffs_4)[int(0)] + r2_4 * ((*coeffs_4)[int(1)] + r2_4 * ((*coeffs_4)[int(2)] + r2_4 * (*coeffs_4)[int(3)]))));
    float2  grid_0 = kb_0 * make_float2 ((*coeffs_4)[int(4)], (*coeffs_4)[int(5)]);
    if((dot_1(grid_0, grid_0)) < 9.99999968265522539e-21f)
    {
        return kb_0;
    }
    float radius_0 = length_1(grid_0);
    float _S379 = grid_0.y;
    float _S380 = grid_0.x;
    float theta_0 = (F32_atan2((_S379), (_S380))) * 0.79577469825744629f;
    float theta_1;
    if(theta_0 < 0.0f)
    {
        theta_1 = theta_0 + 5.0f;
    }
    else
    {
        theta_1 = theta_0;
    }
    int _S381 = int((F32_floor((radius_0))));
    int _S382 = int((F32_floor((theta_1))));
    int2  _S383 = make_int2 (int(0));
    float2  _S384 = make_float2 ((float)_S383.x, (float)_S383.y);
    float2  rt_0 = _S384;
    FixedArray<float, 4>  rows_0;
    int _S385 = clamp_1(_S381 - int(1), int(0), int(6));
    int col_0 = ((_S382 - int(1)) % int(5) + int(5)) % int(5);
    FixedArray<float, 4>  nodes_0;
    bool _S386 = _S385 < int(2);
    float _S387;
    if(_S386)
    {
        _S387 = 0.0f;
    }
    else
    {
        _S387 = (*coeffs_4)[int(8) + (_S385 - int(2)) * int(5) + col_0];
    }
    nodes_0[int(0)] = _S387;
    int col_1 = ((_S382 + int(1) - int(1)) % int(5) + int(5)) % int(5);
    if(_S386)
    {
        _S387 = 0.0f;
    }
    else
    {
        _S387 = (*coeffs_4)[int(8) + (_S385 - int(2)) * int(5) + col_1];
    }
    nodes_0[int(1)] = _S387;
    int col_2 = ((_S382 + int(2) - int(1)) % int(5) + int(5)) % int(5);
    if(_S386)
    {
        _S387 = 0.0f;
    }
    else
    {
        _S387 = (*coeffs_4)[int(8) + (_S385 - int(2)) * int(5) + col_2];
    }
    nodes_0[int(2)] = _S387;
    int col_3 = ((_S382 + int(3) - int(1)) % int(5) + int(5)) % int(5);
    if(_S386)
    {
        _S387 = 0.0f;
    }
    else
    {
        _S387 = (*coeffs_4)[int(8) + (_S385 - int(2)) * int(5) + col_3];
    }
    nodes_0[int(3)] = _S387;
    float _S388 = theta_1 - float(_S382);
    rows_0[int(0)] = DistKBPolarSpline_cubic_0(nodes_0[int(0)], nodes_0[int(1)], nodes_0[int(2)], nodes_0[int(3)], _S388);
    int _S389 = clamp_1(_S381 + int(1) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_1;
    bool _S390 = _S389 < int(2);
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S389 - int(2)) * int(5) + col_0];
    }
    nodes_1[int(0)] = theta_1;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S389 - int(2)) * int(5) + col_1];
    }
    nodes_1[int(1)] = theta_1;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S389 - int(2)) * int(5) + col_2];
    }
    nodes_1[int(2)] = theta_1;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S389 - int(2)) * int(5) + col_3];
    }
    nodes_1[int(3)] = theta_1;
    rows_0[int(1)] = DistKBPolarSpline_cubic_0(nodes_1[int(0)], nodes_1[int(1)], nodes_1[int(2)], nodes_1[int(3)], _S388);
    int _S391 = clamp_1(_S381 + int(2) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_2;
    bool _S392 = _S391 < int(2);
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S391 - int(2)) * int(5) + col_0];
    }
    nodes_2[int(0)] = theta_1;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S391 - int(2)) * int(5) + col_1];
    }
    nodes_2[int(1)] = theta_1;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S391 - int(2)) * int(5) + col_2];
    }
    nodes_2[int(2)] = theta_1;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S391 - int(2)) * int(5) + col_3];
    }
    nodes_2[int(3)] = theta_1;
    rows_0[int(2)] = DistKBPolarSpline_cubic_0(nodes_2[int(0)], nodes_2[int(1)], nodes_2[int(2)], nodes_2[int(3)], _S388);
    int _S393 = clamp_1(_S381 + int(3) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_3;
    bool _S394 = _S393 < int(2);
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S393 - int(2)) * int(5) + col_0];
    }
    nodes_3[int(0)] = theta_1;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S393 - int(2)) * int(5) + col_1];
    }
    nodes_3[int(1)] = theta_1;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S393 - int(2)) * int(5) + col_2];
    }
    nodes_3[int(2)] = theta_1;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(8) + (_S393 - int(2)) * int(5) + col_3];
    }
    nodes_3[int(3)] = theta_1;
    float _S395 = DistKBPolarSpline_cubic_0(nodes_3[int(0)], nodes_3[int(1)], nodes_3[int(2)], nodes_3[int(3)], _S388);
    rows_0[int(3)] = _S395;
    float _S396 = radius_0 - float(_S381);
    *&((&rt_0)->x) = DistKBPolarSpline_cubic_0(rows_0[int(0)], rows_0[int(1)], rows_0[int(2)], _S395, _S396);
    FixedArray<float, 4>  rows_1;
    FixedArray<float, 4>  nodes_4;
    if(_S386)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S385 - int(2)) * int(5) + col_0];
    }
    nodes_4[int(0)] = theta_1;
    if(_S386)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S385 - int(2)) * int(5) + col_1];
    }
    nodes_4[int(1)] = theta_1;
    if(_S386)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S385 - int(2)) * int(5) + col_2];
    }
    nodes_4[int(2)] = theta_1;
    if(_S386)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S385 - int(2)) * int(5) + col_3];
    }
    nodes_4[int(3)] = theta_1;
    rows_1[int(0)] = DistKBPolarSpline_cubic_0(nodes_4[int(0)], nodes_4[int(1)], nodes_4[int(2)], nodes_4[int(3)], _S388);
    FixedArray<float, 4>  nodes_5;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S389 - int(2)) * int(5) + col_0];
    }
    nodes_5[int(0)] = theta_1;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S389 - int(2)) * int(5) + col_1];
    }
    nodes_5[int(1)] = theta_1;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S389 - int(2)) * int(5) + col_2];
    }
    nodes_5[int(2)] = theta_1;
    if(_S390)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S389 - int(2)) * int(5) + col_3];
    }
    nodes_5[int(3)] = theta_1;
    rows_1[int(1)] = DistKBPolarSpline_cubic_0(nodes_5[int(0)], nodes_5[int(1)], nodes_5[int(2)], nodes_5[int(3)], _S388);
    FixedArray<float, 4>  nodes_6;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S391 - int(2)) * int(5) + col_0];
    }
    nodes_6[int(0)] = theta_1;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S391 - int(2)) * int(5) + col_1];
    }
    nodes_6[int(1)] = theta_1;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S391 - int(2)) * int(5) + col_2];
    }
    nodes_6[int(2)] = theta_1;
    if(_S392)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S391 - int(2)) * int(5) + col_3];
    }
    nodes_6[int(3)] = theta_1;
    rows_1[int(2)] = DistKBPolarSpline_cubic_0(nodes_6[int(0)], nodes_6[int(1)], nodes_6[int(2)], nodes_6[int(3)], _S388);
    FixedArray<float, 4>  nodes_7;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S393 - int(2)) * int(5) + col_0];
    }
    nodes_7[int(0)] = theta_1;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S393 - int(2)) * int(5) + col_1];
    }
    nodes_7[int(1)] = theta_1;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S393 - int(2)) * int(5) + col_2];
    }
    nodes_7[int(2)] = theta_1;
    if(_S394)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_4)[int(33) + (_S393 - int(2)) * int(5) + col_3];
    }
    nodes_7[int(3)] = theta_1;
    float _S397 = DistKBPolarSpline_cubic_0(nodes_7[int(0)], nodes_7[int(1)], nodes_7[int(2)], nodes_7[int(3)], _S388);
    rows_1[int(3)] = _S397;
    *&((&rt_0)->y) = DistKBPolarSpline_cubic_0(rows_1[int(0)], rows_1[int(1)], rows_1[int(2)], _S397, _S396);
    return kb_0 + make_float2 (rt_0.x * _S380 - rt_0.y * _S379, rt_0.x * _S379 + rt_0.y * _S380) / make_float2 (radius_0) * make_float2 ((*coeffs_4)[int(6)], (*coeffs_4)[int(7)]);
}

inline __device__ DiffPair_float_0 s_fwd_length_impl_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_16)
{
    float _S398 = *&((&dpx_16->differential_0)->x) * *&((&dpx_16->primal_0)->x);
    float _S399 = *&((&dpx_16->differential_0)->y) * *&((&dpx_16->primal_0)->y);
    float s_diff_len_0 = _S398 + _S398 + (_S399 + _S399);
    DiffPair_float_0 _S400;
    (&_S400)->primal_0 = *&((&dpx_16->primal_0)->x) * *&((&dpx_16->primal_0)->x) + *&((&dpx_16->primal_0)->y) * *&((&dpx_16->primal_0)->y);
    (&_S400)->differential_0 = s_diff_len_0;
    DiffPair_float_0 _S401 = _d_sqrt_1(&_S400);
    DiffPair_float_0 _S402 = { _S401.primal_0, _S401.differential_0 };
    return _S402;
}

inline __device__ DiffPair_float_0 _d_atan2_0(DiffPair_float_0 * dpy_5, DiffPair_float_0 * dpx_17)
{
    float _S403 = dpx_17->primal_0 * dpx_17->primal_0 + dpy_5->primal_0 * dpy_5->primal_0;
    DiffPair_float_0 _S404 = { (F32_atan2((dpy_5->primal_0), (dpx_17->primal_0))), - dpy_5->primal_0 / _S403 * dpx_17->differential_0 + dpx_17->primal_0 / _S403 * dpy_5->differential_0 };
    return _S404;
}

inline __device__ DiffPair_float_0 s_fwd_DistKBPolarSpline_cubic_0(DiffPair_float_0 * dpa_0, DiffPair_float_0 * dpb_0, DiffPair_float_0 * dpc_0, DiffPair_float_0 * dpd_0, DiffPair_float_0 * dpt_0)
{
    float _S405 = 0.5f * dpt_0->primal_0;
    float _S406 = 3.0f * (dpb_0->primal_0 - dpc_0->primal_0) + dpd_0->primal_0 - dpa_0->primal_0;
    float _S407 = 2.0f * dpa_0->primal_0 - 5.0f * dpb_0->primal_0 + 4.0f * dpc_0->primal_0 - dpd_0->primal_0 + dpt_0->primal_0 * _S406;
    float _S408 = dpc_0->primal_0 - dpa_0->primal_0 + dpt_0->primal_0 * _S407;
    DiffPair_float_0 _S409 = { dpb_0->primal_0 + _S405 * _S408, dpb_0->differential_0 + (dpt_0->differential_0 * 0.5f * _S408 + (dpc_0->differential_0 - dpa_0->differential_0 + (dpt_0->differential_0 * _S407 + (dpa_0->differential_0 * 2.0f - dpb_0->differential_0 * 5.0f + dpc_0->differential_0 * 4.0f - dpd_0->differential_0 + (dpt_0->differential_0 * _S406 + ((dpb_0->differential_0 - dpc_0->differential_0) * 3.0f + dpd_0->differential_0 - dpa_0->differential_0) * dpt_0->primal_0)) * dpt_0->primal_0)) * _S405) };
    return _S409;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistKBPolarSpline_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_2, FixedArray<float, 58>  * coeffs_5)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S410;
    (&_S410)->primal_0 = dpuv_2->primal_0;
    (&_S410)->differential_0 = dpuv_2->differential_0;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S411;
    (&_S411)->primal_0 = dpuv_2->primal_0;
    (&_S411)->differential_0 = dpuv_2->differential_0;
    DiffPair_float_0 _S412 = _d_dot_1(&_S410, &_S411);
    float _S413 = (*coeffs_5)[int(2)] + _S412.primal_0 * (*coeffs_5)[int(3)];
    float _S414 = (*coeffs_5)[int(1)] + _S412.primal_0 * _S413;
    float _S415 = (*coeffs_5)[int(0)] + _S412.primal_0 * _S414;
    float radial_2 = 1.0f + _S412.primal_0 * _S415;
    float2  kb_1 = dpuv_2->primal_0 * make_float2 (radial_2);
    float2  s_diff_kb_0 = dpuv_2->differential_0 * make_float2 (radial_2) + make_float2 (_S412.differential_0 * _S415 + (_S412.differential_0 * _S414 + (_S412.differential_0 * _S413 + _S412.differential_0 * (*coeffs_5)[int(3)] * _S412.primal_0) * _S412.primal_0) * _S412.primal_0) * dpuv_2->primal_0;
    float2  _S416 = make_float2 ((*coeffs_5)[int(4)], (*coeffs_5)[int(5)]);
    float2  grid_1 = kb_1 * _S416;
    float2  _S417 = s_diff_kb_0 * _S416;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S418;
    (&_S418)->primal_0 = grid_1;
    (&_S418)->differential_0 = _S417;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S419;
    (&_S419)->primal_0 = grid_1;
    (&_S419)->differential_0 = _S417;
    DiffPair_float_0 _S420 = _d_dot_1(&_S418, &_S419);
    if((_S420.primal_0) < 9.99999968265522539e-21f)
    {
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S421 = { kb_1, s_diff_kb_0 };
        return _S421;
    }
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S422;
    (&_S422)->primal_0 = grid_1;
    (&_S422)->differential_0 = _S417;
    DiffPair_float_0 _S423 = s_fwd_length_impl_0(&_S422);
    float _S424 = grid_1.y;
    float _S425 = _S417.y;
    float _S426 = grid_1.x;
    float _S427 = _S417.x;
    DiffPair_float_0 _S428;
    (&_S428)->primal_0 = _S424;
    (&_S428)->differential_0 = _S425;
    DiffPair_float_0 _S429;
    (&_S429)->primal_0 = _S426;
    (&_S429)->differential_0 = _S427;
    DiffPair_float_0 _S430 = _d_atan2_0(&_S428, &_S429);
    float theta_2 = _S430.primal_0 * 0.79577469825744629f;
    float _S431 = _S430.differential_0 * 0.79577469825744629f;
    float theta_3;
    if(theta_2 < 0.0f)
    {
        theta_3 = theta_2 + 5.0f;
    }
    else
    {
        theta_3 = theta_2;
    }
    int _S432 = int((F32_floor((_S423.primal_0))));
    int _S433 = int((F32_floor((theta_3))));
    int2  _S434 = make_int2 (int(0));
    float2  rt_1 = make_float2 ((float)_S434.x, (float)_S434.y);
    int _S435 = clamp_1(_S432 - int(1), int(0), int(6));
    int col_4 = ((_S433 - int(1)) % int(5) + int(5)) % int(5);
    bool _S436 = _S435 < int(2);
    int _S437 = (_S435 - int(2)) * int(5);
    int _S438 = int(8) + _S437;
    float _S439 = (*coeffs_5)[_S438 + col_4];
    int col_5 = ((_S433 + int(1) - int(1)) % int(5) + int(5)) % int(5);
    float _S440 = (*coeffs_5)[_S438 + col_5];
    int col_6 = ((_S433 + int(2) - int(1)) % int(5) + int(5)) % int(5);
    float _S441 = (*coeffs_5)[_S438 + col_6];
    int col_7 = ((_S433 + int(3) - int(1)) % int(5) + int(5)) % int(5);
    float _S442 = (*coeffs_5)[_S438 + col_7];
    float _S443 = theta_3 - float(_S433);
    int _S444 = clamp_1(_S432 + int(1) - int(1), int(0), int(6));
    bool _S445 = _S444 < int(2);
    int _S446 = (_S444 - int(2)) * int(5);
    int _S447 = int(8) + _S446;
    float _S448 = (*coeffs_5)[_S447 + col_4];
    float _S449 = (*coeffs_5)[_S447 + col_5];
    float _S450 = (*coeffs_5)[_S447 + col_6];
    float _S451 = (*coeffs_5)[_S447 + col_7];
    int _S452 = clamp_1(_S432 + int(2) - int(1), int(0), int(6));
    bool _S453 = _S452 < int(2);
    int _S454 = (_S452 - int(2)) * int(5);
    int _S455 = int(8) + _S454;
    float _S456 = (*coeffs_5)[_S455 + col_4];
    float _S457 = (*coeffs_5)[_S455 + col_5];
    float _S458 = (*coeffs_5)[_S455 + col_6];
    float _S459 = (*coeffs_5)[_S455 + col_7];
    int _S460 = clamp_1(_S432 + int(3) - int(1), int(0), int(6));
    bool _S461 = _S460 < int(2);
    int _S462 = (_S460 - int(2)) * int(5);
    int _S463 = int(8) + _S462;
    float _S464 = (*coeffs_5)[_S463 + col_4];
    float _S465 = (*coeffs_5)[_S463 + col_5];
    float _S466 = (*coeffs_5)[_S463 + col_6];
    float _S467 = (*coeffs_5)[_S463 + col_7];
    float _S468 = _S423.primal_0 - float(_S432);
    int _S469 = int(33) + _S437;
    float _S470 = (*coeffs_5)[_S469 + col_4];
    float _S471 = (*coeffs_5)[_S469 + col_5];
    float _S472 = (*coeffs_5)[_S469 + col_6];
    float _S473 = (*coeffs_5)[_S469 + col_7];
    int _S474 = int(33) + _S446;
    float _S475 = (*coeffs_5)[_S474 + col_4];
    float _S476 = (*coeffs_5)[_S474 + col_5];
    float _S477 = (*coeffs_5)[_S474 + col_6];
    float _S478 = (*coeffs_5)[_S474 + col_7];
    int _S479 = int(33) + _S454;
    float _S480 = (*coeffs_5)[_S479 + col_4];
    float _S481 = (*coeffs_5)[_S479 + col_5];
    float _S482 = (*coeffs_5)[_S479 + col_6];
    float _S483 = (*coeffs_5)[_S479 + col_7];
    int _S484 = int(33) + _S462;
    float _S485 = (*coeffs_5)[_S484 + col_4];
    float _S486 = (*coeffs_5)[_S484 + col_5];
    float _S487 = (*coeffs_5)[_S484 + col_6];
    float _S488 = (*coeffs_5)[_S484 + col_7];
    float2  _S489 = make_float2 ((*coeffs_5)[int(6)], (*coeffs_5)[int(7)]);
    if(_S436)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S439;
    }
    float _S490;
    if(_S436)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S440;
    }
    float _S491;
    if(_S436)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S441;
    }
    float _S492;
    if(_S436)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S442;
    }
    DiffPair_float_0 _S493;
    (&_S493)->primal_0 = theta_3;
    (&_S493)->differential_0 = 0.0f;
    DiffPair_float_0 _S494;
    (&_S494)->primal_0 = _S490;
    (&_S494)->differential_0 = 0.0f;
    DiffPair_float_0 _S495;
    (&_S495)->primal_0 = _S491;
    (&_S495)->differential_0 = 0.0f;
    DiffPair_float_0 _S496;
    (&_S496)->primal_0 = _S492;
    (&_S496)->differential_0 = 0.0f;
    DiffPair_float_0 _S497;
    (&_S497)->primal_0 = _S443;
    (&_S497)->differential_0 = _S431;
    DiffPair_float_0 _S498 = s_fwd_DistKBPolarSpline_cubic_0(&_S493, &_S494, &_S495, &_S496, &_S497);
    if(_S445)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S448;
    }
    if(_S445)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S449;
    }
    if(_S445)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S450;
    }
    if(_S445)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S451;
    }
    DiffPair_float_0 _S499;
    (&_S499)->primal_0 = theta_3;
    (&_S499)->differential_0 = 0.0f;
    DiffPair_float_0 _S500;
    (&_S500)->primal_0 = _S490;
    (&_S500)->differential_0 = 0.0f;
    DiffPair_float_0 _S501;
    (&_S501)->primal_0 = _S491;
    (&_S501)->differential_0 = 0.0f;
    DiffPair_float_0 _S502;
    (&_S502)->primal_0 = _S492;
    (&_S502)->differential_0 = 0.0f;
    DiffPair_float_0 _S503;
    (&_S503)->primal_0 = _S443;
    (&_S503)->differential_0 = _S431;
    DiffPair_float_0 _S504 = s_fwd_DistKBPolarSpline_cubic_0(&_S499, &_S500, &_S501, &_S502, &_S503);
    if(_S453)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S456;
    }
    if(_S453)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S457;
    }
    if(_S453)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S458;
    }
    if(_S453)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S459;
    }
    DiffPair_float_0 _S505;
    (&_S505)->primal_0 = theta_3;
    (&_S505)->differential_0 = 0.0f;
    DiffPair_float_0 _S506;
    (&_S506)->primal_0 = _S490;
    (&_S506)->differential_0 = 0.0f;
    DiffPair_float_0 _S507;
    (&_S507)->primal_0 = _S491;
    (&_S507)->differential_0 = 0.0f;
    DiffPair_float_0 _S508;
    (&_S508)->primal_0 = _S492;
    (&_S508)->differential_0 = 0.0f;
    DiffPair_float_0 _S509;
    (&_S509)->primal_0 = _S443;
    (&_S509)->differential_0 = _S431;
    DiffPair_float_0 _S510 = s_fwd_DistKBPolarSpline_cubic_0(&_S505, &_S506, &_S507, &_S508, &_S509);
    if(_S461)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S464;
    }
    if(_S461)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S465;
    }
    if(_S461)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S466;
    }
    if(_S461)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S467;
    }
    DiffPair_float_0 _S511;
    (&_S511)->primal_0 = theta_3;
    (&_S511)->differential_0 = 0.0f;
    DiffPair_float_0 _S512;
    (&_S512)->primal_0 = _S490;
    (&_S512)->differential_0 = 0.0f;
    DiffPair_float_0 _S513;
    (&_S513)->primal_0 = _S491;
    (&_S513)->differential_0 = 0.0f;
    DiffPair_float_0 _S514;
    (&_S514)->primal_0 = _S492;
    (&_S514)->differential_0 = 0.0f;
    DiffPair_float_0 _S515;
    (&_S515)->primal_0 = _S443;
    (&_S515)->differential_0 = _S431;
    DiffPair_float_0 _S516 = s_fwd_DistKBPolarSpline_cubic_0(&_S511, &_S512, &_S513, &_S514, &_S515);
    DiffPair_float_0 _S517;
    (&_S517)->primal_0 = _S498.primal_0;
    (&_S517)->differential_0 = _S498.differential_0;
    DiffPair_float_0 _S518;
    (&_S518)->primal_0 = _S504.primal_0;
    (&_S518)->differential_0 = _S504.differential_0;
    DiffPair_float_0 _S519;
    (&_S519)->primal_0 = _S510.primal_0;
    (&_S519)->differential_0 = _S510.differential_0;
    DiffPair_float_0 _S520;
    (&_S520)->primal_0 = _S516.primal_0;
    (&_S520)->differential_0 = _S516.differential_0;
    DiffPair_float_0 _S521;
    (&_S521)->primal_0 = _S468;
    (&_S521)->differential_0 = _S423.differential_0;
    DiffPair_float_0 _S522 = s_fwd_DistKBPolarSpline_cubic_0(&_S517, &_S518, &_S519, &_S520, &_S521);
    float2  _S523 = rt_1;
    *&((&_S523)->x) = _S522.primal_0;
    float2  _S524 = make_float2 (0.0f);
    *&((&_S524)->x) = _S522.differential_0;
    if(_S436)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S470;
    }
    if(_S436)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S471;
    }
    if(_S436)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S472;
    }
    if(_S436)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S473;
    }
    DiffPair_float_0 _S525;
    (&_S525)->primal_0 = theta_3;
    (&_S525)->differential_0 = 0.0f;
    DiffPair_float_0 _S526;
    (&_S526)->primal_0 = _S490;
    (&_S526)->differential_0 = 0.0f;
    DiffPair_float_0 _S527;
    (&_S527)->primal_0 = _S491;
    (&_S527)->differential_0 = 0.0f;
    DiffPair_float_0 _S528;
    (&_S528)->primal_0 = _S492;
    (&_S528)->differential_0 = 0.0f;
    DiffPair_float_0 _S529;
    (&_S529)->primal_0 = _S443;
    (&_S529)->differential_0 = _S431;
    DiffPair_float_0 _S530 = s_fwd_DistKBPolarSpline_cubic_0(&_S525, &_S526, &_S527, &_S528, &_S529);
    if(_S445)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S475;
    }
    if(_S445)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S476;
    }
    if(_S445)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S477;
    }
    if(_S445)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S478;
    }
    DiffPair_float_0 _S531;
    (&_S531)->primal_0 = theta_3;
    (&_S531)->differential_0 = 0.0f;
    DiffPair_float_0 _S532;
    (&_S532)->primal_0 = _S490;
    (&_S532)->differential_0 = 0.0f;
    DiffPair_float_0 _S533;
    (&_S533)->primal_0 = _S491;
    (&_S533)->differential_0 = 0.0f;
    DiffPair_float_0 _S534;
    (&_S534)->primal_0 = _S492;
    (&_S534)->differential_0 = 0.0f;
    DiffPair_float_0 _S535;
    (&_S535)->primal_0 = _S443;
    (&_S535)->differential_0 = _S431;
    DiffPair_float_0 _S536 = s_fwd_DistKBPolarSpline_cubic_0(&_S531, &_S532, &_S533, &_S534, &_S535);
    if(_S453)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S480;
    }
    if(_S453)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S481;
    }
    if(_S453)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S482;
    }
    if(_S453)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S483;
    }
    DiffPair_float_0 _S537;
    (&_S537)->primal_0 = theta_3;
    (&_S537)->differential_0 = 0.0f;
    DiffPair_float_0 _S538;
    (&_S538)->primal_0 = _S490;
    (&_S538)->differential_0 = 0.0f;
    DiffPair_float_0 _S539;
    (&_S539)->primal_0 = _S491;
    (&_S539)->differential_0 = 0.0f;
    DiffPair_float_0 _S540;
    (&_S540)->primal_0 = _S492;
    (&_S540)->differential_0 = 0.0f;
    DiffPair_float_0 _S541;
    (&_S541)->primal_0 = _S443;
    (&_S541)->differential_0 = _S431;
    DiffPair_float_0 _S542 = s_fwd_DistKBPolarSpline_cubic_0(&_S537, &_S538, &_S539, &_S540, &_S541);
    if(_S461)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S485;
    }
    if(_S461)
    {
        _S490 = 0.0f;
    }
    else
    {
        _S490 = _S486;
    }
    if(_S461)
    {
        _S491 = 0.0f;
    }
    else
    {
        _S491 = _S487;
    }
    if(_S461)
    {
        _S492 = 0.0f;
    }
    else
    {
        _S492 = _S488;
    }
    DiffPair_float_0 _S543;
    (&_S543)->primal_0 = theta_3;
    (&_S543)->differential_0 = 0.0f;
    DiffPair_float_0 _S544;
    (&_S544)->primal_0 = _S490;
    (&_S544)->differential_0 = 0.0f;
    DiffPair_float_0 _S545;
    (&_S545)->primal_0 = _S491;
    (&_S545)->differential_0 = 0.0f;
    DiffPair_float_0 _S546;
    (&_S546)->primal_0 = _S492;
    (&_S546)->differential_0 = 0.0f;
    DiffPair_float_0 _S547;
    (&_S547)->primal_0 = _S443;
    (&_S547)->differential_0 = _S431;
    DiffPair_float_0 _S548 = s_fwd_DistKBPolarSpline_cubic_0(&_S543, &_S544, &_S545, &_S546, &_S547);
    DiffPair_float_0 _S549;
    (&_S549)->primal_0 = _S530.primal_0;
    (&_S549)->differential_0 = _S530.differential_0;
    DiffPair_float_0 _S550;
    (&_S550)->primal_0 = _S536.primal_0;
    (&_S550)->differential_0 = _S536.differential_0;
    DiffPair_float_0 _S551;
    (&_S551)->primal_0 = _S542.primal_0;
    (&_S551)->differential_0 = _S542.differential_0;
    DiffPair_float_0 _S552;
    (&_S552)->primal_0 = _S548.primal_0;
    (&_S552)->differential_0 = _S548.differential_0;
    DiffPair_float_0 _S553;
    (&_S553)->primal_0 = _S468;
    (&_S553)->differential_0 = _S423.differential_0;
    DiffPair_float_0 _S554 = s_fwd_DistKBPolarSpline_cubic_0(&_S549, &_S550, &_S551, &_S552, &_S553);
    *&((&_S523)->y) = _S554.primal_0;
    *&((&_S524)->y) = _S554.differential_0;
    float _S555 = _S523.x;
    float _S556 = _S524.x;
    float _S557 = _S523.y;
    float _S558 = _S524.y;
    float2  _S559 = make_float2 (_S555 * _S426 - _S557 * _S424, _S555 * _S424 + _S557 * _S426);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S560 = { kb_1 + _S559 / make_float2 (_S423.primal_0) * _S489, s_diff_kb_0 + (make_float2 (_S556 * _S426 + _S427 * _S555 - (_S558 * _S424 + _S425 * _S557), _S556 * _S424 + _S425 * _S555 + (_S558 * _S426 + _S427 * _S557)) * make_float2 (_S423.primal_0) - _S559 * make_float2 (_S423.differential_0)) / make_float2 (_S423.primal_0 * _S423.primal_0) * _S489 };
    return _S560;
}

inline __device__ bool undistort_point_3(float2  uv_6, FixedArray<float, 58>  * dist_coeffs_3, int maxiter_3, float2  * uv_undist_3)
{
    int i_7 = int(0);
    float2  q_4 = uv_6;
    for(;;)
    {
        if(i_7 < maxiter_3)
        {
        }
        else
        {
            break;
        }
        float2  _S561 = DistKBPolarSpline_distort_0(q_4, dist_coeffs_3);
        float2  r_4 = _S561 - uv_6;
        float2  _S562 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S563;
        (&_S563)->primal_0 = q_4;
        (&_S563)->differential_0 = _S562;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S564 = s_fwd_DistKBPolarSpline_distort_0(&_S563, dist_coeffs_3);
        float2  _S565 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S566;
        (&_S566)->primal_0 = q_4;
        (&_S566)->differential_0 = _S565;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S567 = s_fwd_DistKBPolarSpline_distort_0(&_S566, dist_coeffs_3);
        Matrix<float, 2, 2>  _S568 = transpose_0(makeMatrix<float, 2, 2> (_S564.differential_0, _S567.differential_0));
        float inv_det_2 = 1.0f / (_S568.rows[int(0)].x * _S568.rows[int(1)].y - _S568.rows[int(0)].y * _S568.rows[int(1)].x);
        float _S569 = r_4.x;
        float _S570 = r_4.y;
        float2  q_5 = q_4 - make_float2 ((_S569 * _S568.rows[int(1)].y - _S570 * _S568.rows[int(0)].y) * inv_det_2, (- _S569 * _S568.rows[int(1)].x + _S570 * _S568.rows[int(0)].x) * inv_det_2);
        i_7 = i_7 + int(1);
        q_4 = q_5;
    }
    *uv_undist_3 = q_4;
    float2  _S571 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S572;
    (&_S572)->primal_0 = q_4;
    (&_S572)->differential_0 = _S571;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S573 = s_fwd_DistKBPolarSpline_distort_0(&_S572, dist_coeffs_3);
    float2  _S574 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S575;
    (&_S575)->primal_0 = q_4;
    (&_S575)->differential_0 = _S574;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S576 = s_fwd_DistKBPolarSpline_distort_0(&_S575, dist_coeffs_3);
    Matrix<float, 2, 2>  _S577 = transpose_0(makeMatrix<float, 2, 2> (_S573.differential_0, _S576.differential_0));
    float _S578 = (F32_min((determinant_0(_S577)), ((F32_min((_S577.rows[int(0)].x), (_S577.rows[int(1)].y))))));
    bool _S579;
    if(_S578 > 0.25f)
    {
        _S579 = _S578 < 4.0f;
    }
    else
    {
        _S579 = false;
    }
    if(_S579)
    {
        float2  _S580 = DistKBPolarSpline_distort_0(q_4, dist_coeffs_3);
        _S579 = (dot_1(q_4, _S580)) >= 0.0f;
    }
    else
    {
        _S579 = false;
    }
    if(_S579)
    {
        float2  _S581 = DistKBPolarSpline_distort_0(*uv_undist_3, dist_coeffs_3);
        _S579 = (length_1(_S581 - uv_6)) < 0.00999999977648258f;
    }
    else
    {
        _S579 = false;
    }
    return _S579;
}

inline __device__ float3  normalize_0(float3  x_21)
{
    return x_21 / make_float3 (length_0(x_21));
}

inline __device__ float3  unproject_raydir_0(float2  uv_7, int camera_model_0, bool is_ray_depth_0)
{
    float3  raydir_0;
    bool is_unit_0;
    if(camera_model_0 == int(1))
    {
        float theta_4 = length_1(uv_7);
        float3  _S582 = make_float3 ((uv_7 / make_float2 ((F32_max((theta_4), (1.00000001168609742e-07f)))) * make_float2 ((F32_sin((theta_4))))).x, (uv_7 / make_float2 ((F32_max((theta_4), (1.00000001168609742e-07f)))) * make_float2 ((F32_sin((theta_4))))).y, (F32_cos((theta_4))));
        is_unit_0 = true;
        raydir_0 = _S582;
    }
    else
    {
        bool _S583 = camera_model_0 == int(2);
        if(_S583)
        {
            float r_5 = length_1(uv_7);
            raydir_0 = make_float3 ((uv_7 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_5 * r_5)))))))).x, (uv_7 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_5 * r_5)))))))).y, 1.0f - 0.5f * r_5 * r_5);
        }
        else
        {
            raydir_0 = make_float3 (uv_7.x, uv_7.y, 1.0f);
        }
        is_unit_0 = _S583;
    }
    if(is_ray_depth_0)
    {
        if(is_unit_0)
        {
        }
        else
        {
            raydir_0 = normalize_0(raydir_0);
        }
    }
    else
    {
        raydir_0 = raydir_0 / make_float3 (raydir_0.z);
    }
    return raydir_0;
}

inline __device__ float3  generate_ray_d2n_none(float2  pix_pos_0, float4  intrins_0, FixedArray<float, 1>  dist_coeffs_4, int camera_model_1, bool is_ray_depth_1)
{
    float3  _S584;
    for(;;)
    {
        float2  uv_8 = (pix_pos_0 - float2 {intrins_0.z, intrins_0.w}) / float2 {intrins_0.x, intrins_0.y};
        FixedArray<float, 1>  _S585 = dist_coeffs_4;
        float2  uv_u_0;
        bool _S586 = undistort_point_0(uv_8, &_S585, int(12), &uv_u_0);
        if(!_S586)
        {
            int3  _S587 = make_int3 (int(0));
            float3  _S588 = make_float3 ((float)_S587.x, (float)_S587.y, (float)_S587.z);
            _S584 = _S588;
            break;
        }
        _S584 = unproject_raydir_0(uv_u_0, camera_model_1, is_ray_depth_1);
        break;
    }
    return _S584;
}

inline __device__ float3  depth_to_point_none(float2  pix_pos_1, float4  intrins_1, FixedArray<float, 1>  dist_coeffs_5, int camera_model_2, bool is_ray_depth_2, float depth_2)
{
    float3  _S589;
    for(;;)
    {
        float2  uv_9 = (pix_pos_1 - float2 {intrins_1.z, intrins_1.w}) / float2 {intrins_1.x, intrins_1.y};
        FixedArray<float, 1>  _S590 = dist_coeffs_5;
        float2  uv_u_1;
        bool _S591 = undistort_point_0(uv_9, &_S590, int(12), &uv_u_1);
        if(!_S591)
        {
            _S589 = make_float3 (0.0f);
            break;
        }
        _S589 = make_float3 (depth_2) * unproject_raydir_0(uv_u_1, camera_model_2, is_ray_depth_2);
        break;
    }
    return _S589;
}

struct s_bwd_prop_depth_to_point_Intermediates_0
{
    float2  _S592;
    bool _S593;
};

inline __device__ float s_primal_ctx_sin_0(float _S594)
{
    return (F32_sin((_S594)));
}

inline __device__ float s_primal_ctx_cos_0(float _S595)
{
    return (F32_cos((_S595)));
}

inline __device__ float s_primal_ctx_sqrt_0(float _S596)
{
    return (F32_sqrt((_S596)));
}

inline __device__ float3  s_primal_ctx_unproject_raydir_0(float2  dpuv_3, int camera_model_3, bool is_ray_depth_3)
{
    float3  raydir_1;
    bool is_unit_1;
    if(camera_model_3 == int(1))
    {
        float _S597 = length_1(dpuv_3);
        float3  _S598 = make_float3 ((dpuv_3 / make_float2 ((F32_max((_S597), (1.00000001168609742e-07f)))) * make_float2 (s_primal_ctx_sin_0(_S597))).x, (dpuv_3 / make_float2 ((F32_max((_S597), (1.00000001168609742e-07f)))) * make_float2 (s_primal_ctx_sin_0(_S597))).y, s_primal_ctx_cos_0(_S597));
        is_unit_1 = true;
        raydir_1 = _S598;
    }
    else
    {
        bool _S599 = camera_model_3 == int(2);
        if(_S599)
        {
            float _S600 = length_1(dpuv_3);
            raydir_1 = make_float3 ((dpuv_3 * make_float2 (s_primal_ctx_sqrt_0((F32_max((0.0f), (1.0f - 0.25f * _S600 * _S600)))))).x, (dpuv_3 * make_float2 (s_primal_ctx_sqrt_0((F32_max((0.0f), (1.0f - 0.25f * _S600 * _S600)))))).y, 1.0f - 0.5f * _S600 * _S600);
        }
        else
        {
            raydir_1 = make_float3 (dpuv_3.x, dpuv_3.y, 1.0f);
        }
        is_unit_1 = _S599;
    }
    if(is_ray_depth_3)
    {
        if(is_unit_1)
        {
        }
        else
        {
            raydir_1 = normalize_0(raydir_1);
        }
    }
    else
    {
        raydir_1 = raydir_1 / make_float3 (raydir_1.z);
    }
    return raydir_1;
}

inline __device__ float depth_to_point_vjp_none(float2  pix_pos_2, float4  intrins_2, FixedArray<float, 1>  dist_coeffs_6, int camera_model_4, bool is_ray_depth_4, float depth_3, float3  v_point_0)
{
    float2  _S601 = make_float2 (0.0f);
    s_bwd_prop_depth_to_point_Intermediates_0 _S602;
    (&_S602)->_S592 = _S601;
    (&_S602)->_S593 = false;
    float2  uv_10 = (pix_pos_2 - float2 {intrins_2.z, intrins_2.w}) / float2 {intrins_2.x, intrins_2.y};
    float2  _S603 = _S601;
    FixedArray<float, 1>  _S604 = dist_coeffs_6;
    bool _S605 = undistort_point_0(uv_10, &_S604, int(12), &_S603);
    (&_S602)->_S592 = _S603;
    (&_S602)->_S593 = _S605;
    s_bwd_prop_depth_to_point_Intermediates_0 _S606 = _S602;
    float3  _S607 = make_float3 (0.0f);
    bool _S608 = !!_S602._S593;
    float3  _S609;
    if(_S608)
    {
        _S609 = s_primal_ctx_unproject_raydir_0(_S606._S592, camera_model_4, is_ray_depth_4);
    }
    else
    {
        _S609 = _S607;
    }
    if(_S608)
    {
        _S609 = _S609 * v_point_0;
    }
    else
    {
        _S609 = _S607;
    }
    return _S609.x + _S609.y + _S609.z;
}

inline __device__ float3  depth_to_normal_none(float2  pix_center_0, float4  intrins_3, FixedArray<float, 1>  dist_coeffs_7, int camera_model_5, bool is_ray_depth_5, float4  depths_0)
{
    float3  normal_2;
    for(;;)
    {
        bool _S610;
        if((depths_0.x) == 0.0f)
        {
            _S610 = true;
        }
        else
        {
            _S610 = (depths_0.y) == 0.0f;
        }
        if(_S610)
        {
            _S610 = true;
        }
        else
        {
            _S610 = (depths_0.z) == 0.0f;
        }
        if(_S610)
        {
            _S610 = true;
        }
        else
        {
            _S610 = (depths_0.w) == 0.0f;
        }
        if(_S610)
        {
            normal_2 = make_float3 (0.0f);
            break;
        }
        float3  * _S611;
        float3  * _S612;
        float3  * _S613;
        float3  * _S614;
        int _S615;
        FixedArray<float3 , 4>  points_2;
        for(;;)
        {
            float2  _S616 = float2 {intrins_3.z, intrins_3.w};
            float2  _S617 = float2 {intrins_3.x, intrins_3.y};
            float2  uv_11 = (pix_center_0 + make_float2 (-1.0f, -0.0f) - _S616) / _S617;
            FixedArray<float, 1>  _S618 = dist_coeffs_7;
            float2  uv_u_2;
            bool _S619 = undistort_point_0(uv_11, &_S618, int(12), &uv_u_2);
            if(!_S619)
            {
                float3  _S620 = make_float3 (0.0f);
                _S615 = int(0);
                _S614 = nullptr;
                _S613 = nullptr;
                _S612 = nullptr;
                _S611 = nullptr;
                normal_2 = _S620;
                break;
            }
            points_2[int(0)] = make_float3 (depths_0.x) * unproject_raydir_0(uv_u_2, camera_model_5, is_ray_depth_5);
            for(;;)
            {
                float2  uv_12 = (pix_center_0 + make_float2 (1.0f, -0.0f) - _S616) / _S617;
                FixedArray<float, 1>  _S621 = dist_coeffs_7;
                float2  uv_u_3;
                bool _S622 = undistort_point_0(uv_12, &_S621, int(12), &uv_u_3);
                if(!_S622)
                {
                    float3  _S623 = make_float3 (0.0f);
                    _S615 = int(0);
                    _S614 = nullptr;
                    normal_2 = _S623;
                    break;
                }
                points_2[int(1)] = make_float3 (depths_0.y) * unproject_raydir_0(uv_u_3, camera_model_5, is_ray_depth_5);
                _S615 = int(2);
                _S614 = &points_2[int(1)];
                break;
            }
            if(_S615 != int(2))
            {
                _S613 = &points_2[int(0)];
                _S612 = nullptr;
                _S611 = nullptr;
                break;
            }
            float2  uv_13 = (pix_center_0 + make_float2 (0.0f, -1.0f) - _S616) / _S617;
            FixedArray<float, 1>  _S624 = dist_coeffs_7;
            float2  uv_u_4;
            bool _S625 = undistort_point_0(uv_13, &_S624, int(12), &uv_u_4);
            if(!_S625)
            {
                float3  _S626 = make_float3 (0.0f);
                _S615 = int(0);
                _S613 = &points_2[int(0)];
                _S612 = nullptr;
                _S611 = nullptr;
                normal_2 = _S626;
                break;
            }
            points_2[int(2)] = make_float3 (depths_0.z) * unproject_raydir_0(uv_u_4, camera_model_5, is_ray_depth_5);
            for(;;)
            {
                float2  uv_14 = (pix_center_0 + make_float2 (0.0f, 1.0f) - _S616) / _S617;
                FixedArray<float, 1>  _S627 = dist_coeffs_7;
                float2  uv_u_5;
                bool _S628 = undistort_point_0(uv_14, &_S627, int(12), &uv_u_5);
                if(!_S628)
                {
                    float3  _S629 = make_float3 (0.0f);
                    _S615 = int(0);
                    _S613 = nullptr;
                    normal_2 = _S629;
                    break;
                }
                points_2[int(3)] = make_float3 (depths_0.w) * unproject_raydir_0(uv_u_5, camera_model_5, is_ray_depth_5);
                _S615 = int(2);
                _S613 = &points_2[int(3)];
                break;
            }
            if(_S615 != int(2))
            {
                float3  * _S630 = _S613;
                _S613 = &points_2[int(0)];
                _S612 = _S630;
                _S611 = &points_2[int(2)];
                break;
            }
            float3  * _S631 = _S613;
            _S615 = int(1);
            _S613 = &points_2[int(0)];
            _S612 = _S631;
            _S611 = &points_2[int(2)];
            break;
        }
        if(_S615 != int(1))
        {
            break;
        }
        float3  normal_3 = cross_0(*_S614 - *_S613, - (*_S612 - *_S611));
        if((dot_0(normal_3, normal_3)) != 0.0f)
        {
            normal_2 = normal_3 / make_float3 (length_0(normal_3));
        }
        else
        {
            normal_2 = normal_3;
        }
        break;
    }
    return normal_2;
}

struct s_bwd_prop_depth_to_normal_Intermediates_0
{
    float2  _S632;
    bool _S633;
    float2  _S634;
    bool _S635;
    float2  _S636;
    bool _S637;
    float2  _S638;
    bool _S639;
};

inline __device__ void depth_to_normal_vjp_none(float2  pix_center_1, float4  intrins_4, FixedArray<float, 1>  dist_coeffs_8, int camera_model_6, bool is_ray_depth_6, float4  depths_1, float3  v_normal_1, float4  * v_depths_0)
{
    float2  _S640 = make_float2 (0.0f);
    s_bwd_prop_depth_to_normal_Intermediates_0 _S641;
    (&_S641)->_S632 = _S640;
    (&_S641)->_S633 = false;
    (&_S641)->_S634 = _S640;
    (&_S641)->_S635 = false;
    (&_S641)->_S636 = _S640;
    (&_S641)->_S637 = false;
    (&_S641)->_S638 = _S640;
    (&_S641)->_S639 = false;
    (&_S641)->_S632 = _S640;
    (&_S641)->_S633 = false;
    (&_S641)->_S634 = _S640;
    (&_S641)->_S635 = false;
    (&_S641)->_S636 = _S640;
    (&_S641)->_S637 = false;
    (&_S641)->_S638 = _S640;
    (&_S641)->_S639 = false;
    bool _S642 = (depths_1.x) == 0.0f;
    bool _runFlag_3;
    if(_S642)
    {
        _runFlag_3 = true;
    }
    else
    {
        _runFlag_3 = (depths_1.y) == 0.0f;
    }
    if(_runFlag_3)
    {
        _runFlag_3 = true;
    }
    else
    {
        _runFlag_3 = (depths_1.z) == 0.0f;
    }
    if(_runFlag_3)
    {
        _runFlag_3 = true;
    }
    else
    {
        _runFlag_3 = (depths_1.w) == 0.0f;
    }
    int _S643;
    if(!_runFlag_3)
    {
        float2  _S644 = float2 {intrins_4.z, intrins_4.w};
        float2  _S645 = float2 {intrins_4.x, intrins_4.y};
        float2  uv_15 = (pix_center_1 + make_float2 (-1.0f, -0.0f) - _S644) / _S645;
        float2  _S646 = _S640;
        FixedArray<float, 1>  _S647 = dist_coeffs_8;
        bool _S648 = undistort_point_0(uv_15, &_S647, int(12), &_S646);
        (&_S641)->_S632 = _S646;
        (&_S641)->_S633 = _S648;
        bool _S649 = !!_S648;
        if(_S649)
        {
            float2  uv_16 = (pix_center_1 + make_float2 (1.0f, -0.0f) - _S644) / _S645;
            float2  _S650 = _S640;
            FixedArray<float, 1>  _S651 = dist_coeffs_8;
            bool _S652 = undistort_point_0(uv_16, &_S651, int(12), &_S650);
            (&_S641)->_S634 = _S650;
            (&_S641)->_S635 = _S652;
            if(!!_S652)
            {
                _S643 = int(2);
            }
            else
            {
                _S643 = int(0);
            }
            if(_S643 != int(2))
            {
                _runFlag_3 = false;
            }
            else
            {
                _runFlag_3 = _S649;
            }
            if(_runFlag_3)
            {
                float2  uv_17 = (pix_center_1 + make_float2 (0.0f, -1.0f) - _S644) / _S645;
                float2  _S653 = _S640;
                FixedArray<float, 1>  _S654 = dist_coeffs_8;
                bool _S655 = undistort_point_0(uv_17, &_S654, int(12), &_S653);
                (&_S641)->_S636 = _S653;
                (&_S641)->_S637 = _S655;
                if(!_S655)
                {
                    _runFlag_3 = false;
                }
                if(_runFlag_3)
                {
                    float2  uv_18 = (pix_center_1 + make_float2 (0.0f, 1.0f) - _S644) / _S645;
                    float2  _S656 = _S640;
                    FixedArray<float, 1>  _S657 = dist_coeffs_8;
                    bool _S658 = undistort_point_0(uv_18, &_S657, int(12), &_S656);
                    (&_S641)->_S638 = _S656;
                    (&_S641)->_S639 = _S658;
                }
            }
        }
    }
    s_bwd_prop_depth_to_normal_Intermediates_0 _S659 = _S641;
    float3  _S660 = make_float3 (0.0f);
    if(_S642)
    {
        _runFlag_3 = true;
    }
    else
    {
        _runFlag_3 = (depths_1.y) == 0.0f;
    }
    if(_runFlag_3)
    {
        _runFlag_3 = true;
    }
    else
    {
        _runFlag_3 = (depths_1.z) == 0.0f;
    }
    if(_runFlag_3)
    {
        _runFlag_3 = true;
    }
    else
    {
        _runFlag_3 = (depths_1.w) == 0.0f;
    }
    bool _S661 = !_runFlag_3;
    bool _runFlag_4;
    bool _runFlag_5;
    bool _S662;
    bool _runFlag_6;
    bool _S663;
    bool _S664;
    FixedArray<float3 , 4>  points_3;
    float3  _S665;
    float3  _S666;
    float3  _S667;
    float3  _S668;
    float3  _S669;
    float3  _S670;
    float3  _S671;
    float3  _S672;
    float3  _S673;
    if(_S661)
    {
        bool _S674 = !!_S659._S633;
        if(_S674)
        {
            float3  _S675 = s_primal_ctx_unproject_raydir_0(_S659._S632, camera_model_6, is_ray_depth_6);
            float3  _S676 = make_float3 (depths_1.x) * _S675;
            bool _S677 = !!_S659._S635;
            if(_S677)
            {
                float3  _S678 = s_primal_ctx_unproject_raydir_0(_S659._S634, camera_model_6, is_ray_depth_6);
                float3  _S679 = make_float3 (depths_1.y) * _S678;
                _S643 = int(2);
                points_3[int(0)] = _S676;
                points_3[int(1)] = _S679;
                points_3[int(2)] = _S660;
                points_3[int(3)] = _S660;
                _S665 = _S678;
            }
            else
            {
                _S643 = int(0);
                points_3[int(0)] = _S676;
                points_3[int(1)] = _S660;
                points_3[int(2)] = _S660;
                points_3[int(3)] = _S660;
                _S665 = _S660;
            }
            if(_S643 != int(2))
            {
                _runFlag_3 = false;
            }
            else
            {
                _runFlag_3 = _S674;
                _S643 = int(0);
            }
            if(_runFlag_3)
            {
                if(!_S659._S637)
                {
                    _runFlag_4 = false;
                    _S643 = int(0);
                }
                else
                {
                    _runFlag_4 = _runFlag_3;
                }
                if(_runFlag_4)
                {
                    float3  _S680 = s_primal_ctx_unproject_raydir_0(_S659._S636, camera_model_6, is_ray_depth_6);
                    points_3[int(2)] = make_float3 (depths_1.z) * _S680;
                    bool _S681 = !!_S659._S639;
                    int _S682;
                    if(_S681)
                    {
                        float3  _S683 = s_primal_ctx_unproject_raydir_0(_S659._S638, camera_model_6, is_ray_depth_6);
                        points_3[int(3)] = make_float3 (depths_1.w) * _S683;
                        _S682 = int(2);
                        _S666 = _S683;
                    }
                    else
                    {
                        _S682 = int(0);
                        _S666 = _S660;
                    }
                    if(_S682 != int(2))
                    {
                        _runFlag_5 = false;
                        _S643 = _S682;
                    }
                    else
                    {
                        _runFlag_5 = _runFlag_4;
                    }
                    if(_runFlag_5)
                    {
                        _S643 = int(1);
                    }
                    _runFlag_5 = _S681;
                    _S667 = _S680;
                }
                else
                {
                    _runFlag_5 = false;
                    _S666 = _S660;
                    _S667 = _S660;
                }
            }
            else
            {
                _runFlag_4 = false;
                _runFlag_5 = false;
                _S666 = _S660;
                _S667 = _S660;
            }
            float3  _S684 = _S665;
            _S665 = _S666;
            _S666 = _S667;
            _S662 = _S677;
            _S667 = _S684;
            _S668 = _S675;
        }
        else
        {
            _S643 = int(0);
            points_3[int(0)] = _S660;
            points_3[int(1)] = _S660;
            points_3[int(2)] = _S660;
            points_3[int(3)] = _S660;
            _runFlag_3 = false;
            _runFlag_4 = false;
            _runFlag_5 = false;
            _S665 = _S660;
            _S666 = _S660;
            _S662 = false;
            _S667 = _S660;
            _S668 = _S660;
        }
        if(_S643 != int(1))
        {
            _runFlag_6 = false;
        }
        else
        {
            _runFlag_6 = _S661;
        }
        if(_runFlag_6)
        {
            float3  dx_1 = points_3[int(1)] - points_3[int(0)];
            float3  _S685 = - (points_3[int(3)] - points_3[int(2)]);
            float3  _S686 = s_primal_ctx_cross_0(dx_1, _S685);
            bool _S687 = (s_primal_ctx_dot_0(_S686, _S686)) != 0.0f;
            if(_S687)
            {
                float _S688 = length_0(_S686);
                float3  _S689 = make_float3 (_S688);
                _S669 = make_float3 (_S688 * _S688);
                _S670 = _S689;
            }
            else
            {
                _S669 = _S660;
                _S670 = _S660;
            }
            float3  _S690 = _S670;
            _S663 = _S687;
            _S670 = _S686;
            _S671 = _S690;
            _S672 = dx_1;
            _S673 = _S685;
        }
        else
        {
            _S663 = false;
            _S669 = _S660;
            _S670 = _S660;
            _S671 = _S660;
            _S672 = _S660;
            _S673 = _S660;
        }
        bool _S691 = _runFlag_3;
        bool _S692 = _runFlag_4;
        bool _S693 = _runFlag_5;
        float3  _S694 = _S665;
        float3  _S695 = _S666;
        bool _S696 = _S662;
        float3  _S697 = _S667;
        float3  _S698 = _S668;
        _runFlag_3 = _runFlag_6;
        _runFlag_4 = _S663;
        _S665 = _S669;
        _S666 = _S670;
        _S667 = _S671;
        _S668 = _S672;
        _S669 = _S673;
        _runFlag_5 = _S674;
        _S662 = _S691;
        _runFlag_6 = _S692;
        _S663 = _S693;
        _S670 = _S694;
        _S671 = _S695;
        _S664 = _S696;
        _S672 = _S697;
        _S673 = _S698;
    }
    else
    {
        _runFlag_3 = false;
        _runFlag_4 = false;
        _S665 = _S660;
        _S666 = _S660;
        _S667 = _S660;
        _S668 = _S660;
        _S669 = _S660;
        _runFlag_5 = false;
        _S662 = false;
        _runFlag_6 = false;
        _S663 = false;
        _S670 = _S660;
        _S671 = _S660;
        _S664 = false;
        _S672 = _S660;
        _S673 = _S660;
    }
    float4  _S699 = make_float4 (0.0f);
    float4  _S700;
    if(_S661)
    {
        if(_runFlag_3)
        {
            if(_runFlag_4)
            {
                float3  _S701 = v_normal_1 / _S665;
                float3  _S702 = _S666 * - _S701;
                float3  _S703 = _S667 * _S701;
                float _S704 = _S702.x + _S702.y + _S702.z;
                DiffPair_vectorx3Cfloatx2C3x3E_0 _S705;
                (&_S705)->primal_0 = _S666;
                (&_S705)->differential_0 = _S660;
                s_bwd_length_impl_0(&_S705, _S704);
                _S665 = _S703 + _S705.differential_0;
            }
            else
            {
                _S665 = v_normal_1;
            }
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S706;
            (&_S706)->primal_0 = _S666;
            (&_S706)->differential_0 = _S660;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S707;
            (&_S707)->primal_0 = _S666;
            (&_S707)->differential_0 = _S660;
            s_bwd_prop_dot_0(&_S706, &_S707, 0.0f);
            float3  _S708 = _S707.differential_0 + _S706.differential_0 + _S665;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S709;
            (&_S709)->primal_0 = _S668;
            (&_S709)->differential_0 = _S660;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S710;
            (&_S710)->primal_0 = _S669;
            (&_S710)->differential_0 = _S660;
            s_bwd_prop_cross_0(&_S709, &_S710, _S708);
            float3  s_diff_dy_T_1 = - _S710.differential_0;
            float3  _S711 = - s_diff_dy_T_1;
            float3  _S712 = - _S709.differential_0;
            FixedArray<float3 , 4>  _S713;
            _S713[int(0)] = _S660;
            _S713[int(1)] = _S660;
            _S713[int(2)] = _S660;
            _S713[int(3)] = _S660;
            _S713[int(2)] = _S711;
            _S713[int(3)] = s_diff_dy_T_1;
            _S713[int(0)] = _S712;
            _S713[int(1)] = _S709.differential_0;
            points_3[int(0)] = _S713[int(0)];
            points_3[int(1)] = _S713[int(1)];
            points_3[int(2)] = _S713[int(2)];
            points_3[int(3)] = _S713[int(3)];
        }
        else
        {
            points_3[int(0)] = _S660;
            points_3[int(1)] = _S660;
            points_3[int(2)] = _S660;
            points_3[int(3)] = _S660;
        }
        if(_runFlag_5)
        {
            if(_S662)
            {
                if(_runFlag_6)
                {
                    FixedArray<float3 , 4>  _S714 = points_3;
                    FixedArray<float3 , 4>  _S715 = points_3;
                    FixedArray<float3 , 4>  _S716 = points_3;
                    FixedArray<float3 , 4>  _S717 = points_3;
                    if(_S663)
                    {
                        float3  _S718 = _S670 * _S717[int(3)];
                        float _S719 = _S718.x + _S718.y + _S718.z;
                        float4  _S720 = _S699;
                        *&((&_S720)->w) = _S719;
                        points_3[int(0)] = _S714[int(0)];
                        points_3[int(1)] = _S715[int(1)];
                        points_3[int(2)] = _S716[int(2)];
                        points_3[int(3)] = _S660;
                        _S700 = _S720;
                    }
                    else
                    {
                        points_3[int(0)] = _S714[int(0)];
                        points_3[int(1)] = _S715[int(1)];
                        points_3[int(2)] = _S716[int(2)];
                        points_3[int(3)] = _S717[int(3)];
                        _S700 = _S699;
                    }
                    float3  _S721 = _S671 * points_3[int(2)];
                    float _S722 = _S721.x + _S721.y + _S721.z;
                    FixedArray<float3 , 4>  _S723 = points_3;
                    FixedArray<float3 , 4>  _S724 = points_3;
                    float4  _S725 = _S699;
                    *&((&_S725)->z) = _S722;
                    float4  _S726 = _S700 + _S725;
                    points_3[int(0)] = points_3[int(0)];
                    points_3[int(1)] = _S723[int(1)];
                    points_3[int(2)] = _S660;
                    points_3[int(3)] = _S724[int(3)];
                    _S700 = _S726;
                }
                else
                {
                    FixedArray<float3 , 4>  _S727 = points_3;
                    FixedArray<float3 , 4>  _S728 = points_3;
                    FixedArray<float3 , 4>  _S729 = points_3;
                    points_3[int(0)] = points_3[int(0)];
                    points_3[int(1)] = _S727[int(1)];
                    points_3[int(2)] = _S728[int(2)];
                    points_3[int(3)] = _S729[int(3)];
                    _S700 = _S699;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S730 = points_3;
                FixedArray<float3 , 4>  _S731 = points_3;
                FixedArray<float3 , 4>  _S732 = points_3;
                points_3[int(0)] = points_3[int(0)];
                points_3[int(1)] = _S730[int(1)];
                points_3[int(2)] = _S731[int(2)];
                points_3[int(3)] = _S732[int(3)];
                _S700 = _S699;
            }
            if(_S664)
            {
                FixedArray<float3 , 4>  _S733 = points_3;
                float3  _S734 = _S672 * points_3[int(1)];
                float _S735 = _S734.x + _S734.y + _S734.z;
                float4  _S736 = _S699;
                *&((&_S736)->y) = _S735;
                float4  _S737 = _S700 + _S736;
                points_3[int(0)] = _S660;
                points_3[int(1)] = _S660;
                points_3[int(2)] = _S660;
                points_3[int(3)] = _S660;
                _S665 = _S733[int(0)];
                _S700 = _S737;
            }
            else
            {
                FixedArray<float3 , 4>  _S738 = points_3;
                FixedArray<float3 , 4>  _S739 = points_3;
                FixedArray<float3 , 4>  _S740 = points_3;
                points_3[int(0)] = points_3[int(0)];
                points_3[int(1)] = _S738[int(1)];
                points_3[int(2)] = _S739[int(2)];
                points_3[int(3)] = _S740[int(3)];
                _S665 = _S660;
            }
            float3  _S741 = _S673 * (points_3[int(0)] + _S665);
            float _S742 = _S741.x + _S741.y + _S741.z;
            float4  _S743 = _S699;
            *&((&_S743)->x) = _S742;
            _S700 = _S700 + _S743;
        }
        else
        {
            _S700 = _S699;
        }
    }
    else
    {
        _S700 = _S699;
    }
    *v_depths_0 = _S700;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_none(float2  pix_center_2, float4  intrins_5, FixedArray<float, 1>  dist_coeffs_9, int camera_model_7)
{
    float _S744;
    for(;;)
    {
        float2  uv_19 = (pix_center_2 - float2 {intrins_5.z, intrins_5.w}) / float2 {intrins_5.x, intrins_5.y};
        FixedArray<float, 1>  _S745 = dist_coeffs_9;
        float2  uv_u_6;
        bool _S746 = undistort_point_0(uv_19, &_S745, int(12), &uv_u_6);
        if(!_S746)
        {
            _S744 = 0.0f;
            break;
        }
        float3  raydir_2 = unproject_raydir_0(uv_u_6, camera_model_7, false);
        _S744 = float((F32_sign((raydir_2.z)))) / length_0(raydir_2);
        break;
    }
    return _S744;
}

inline __device__ float depth_normal_loss_none(float2  pix_center_3, float4  intrins_6, FixedArray<float, 1>  dist_coeffs_10, int camera_model_8, bool is_ray_depth_7, float4  depths_2, float3  gt_normal_0)
{
    float _S747;
    for(;;)
    {
        float3  _S748;
        float3  * _S749;
        float3  * _S750;
        float3  * _S751;
        float3  * _S752;
        int _S753;
        FixedArray<float3 , 5>  points_4;
        for(;;)
        {
            float2  _S754 = float2 {intrins_6.z, intrins_6.w};
            float2  _S755 = float2 {intrins_6.x, intrins_6.y};
            float2  uv_20 = (pix_center_3 + make_float2 (-1.0f, -0.0f) - _S754) / _S755;
            FixedArray<float, 1>  _S756 = dist_coeffs_10;
            float2  uv_u_7;
            bool _S757 = undistort_point_0(uv_20, &_S756, int(12), &uv_u_7);
            float3  _S758 = make_float3 (0.0f);
            if(!_S757)
            {
                _S753 = int(0);
                _S752 = nullptr;
                _S751 = nullptr;
                _S750 = nullptr;
                _S749 = nullptr;
                _S748 = _S758;
                break;
            }
            float3  raydir_3 = unproject_raydir_0(uv_u_7, camera_model_8, is_ray_depth_7);
            points_4[int(0)] = make_float3 (depths_2.x) * raydir_3;
            float2  uv_21 = (pix_center_3 + make_float2 (1.0f, -0.0f) - _S754) / _S755;
            FixedArray<float, 1>  _S759 = dist_coeffs_10;
            float2  uv_u_8;
            bool _S760 = undistort_point_0(uv_21, &_S759, int(12), &uv_u_8);
            if(!_S760)
            {
                _S753 = int(0);
                _S752 = nullptr;
                _S751 = &points_4[int(0)];
                _S750 = nullptr;
                _S749 = nullptr;
                _S748 = _S758;
                break;
            }
            float3  raydir_4 = unproject_raydir_0(uv_u_8, camera_model_8, is_ray_depth_7);
            points_4[int(1)] = make_float3 (depths_2.y) * raydir_4;
            float2  uv_22 = (pix_center_3 + make_float2 (0.0f, -1.0f) - _S754) / _S755;
            FixedArray<float, 1>  _S761 = dist_coeffs_10;
            float2  uv_u_9;
            bool _S762 = undistort_point_0(uv_22, &_S761, int(12), &uv_u_9);
            if(!_S762)
            {
                _S753 = int(0);
                _S752 = &points_4[int(1)];
                _S751 = &points_4[int(0)];
                _S750 = nullptr;
                _S749 = nullptr;
                _S748 = _S758;
                break;
            }
            float3  raydir_5 = unproject_raydir_0(uv_u_9, camera_model_8, is_ray_depth_7);
            points_4[int(2)] = make_float3 (depths_2.z) * raydir_5;
            float2  uv_23 = (pix_center_3 + make_float2 (0.0f, 1.0f) - _S754) / _S755;
            FixedArray<float, 1>  _S763 = dist_coeffs_10;
            float2  uv_u_10;
            bool _S764 = undistort_point_0(uv_23, &_S763, int(12), &uv_u_10);
            if(!_S764)
            {
                _S753 = int(0);
                _S752 = &points_4[int(1)];
                _S751 = &points_4[int(0)];
                _S750 = nullptr;
                _S749 = &points_4[int(2)];
                _S748 = _S758;
                break;
            }
            float3  raydir_6 = unproject_raydir_0(uv_u_10, camera_model_8, is_ray_depth_7);
            points_4[int(3)] = make_float3 (depths_2.w) * raydir_6;
            float2  uv_24 = (pix_center_3 + make_float2 (0.0f) * make_float2 (0.0f, 3.0f) - _S754) / _S755;
            FixedArray<float, 1>  _S765 = dist_coeffs_10;
            float2  uv_u_11;
            bool _S766 = undistort_point_0(uv_24, &_S765, int(12), &uv_u_11);
            if(!_S766)
            {
                _S753 = int(0);
                _S752 = &points_4[int(1)];
                _S751 = &points_4[int(0)];
                _S750 = &points_4[int(3)];
                _S749 = &points_4[int(2)];
                _S748 = _S758;
                break;
            }
            float3  raydir_7 = unproject_raydir_0(uv_u_11, camera_model_8, is_ray_depth_7);
            _S753 = int(1);
            _S752 = &points_4[int(1)];
            _S751 = &points_4[int(0)];
            _S750 = &points_4[int(3)];
            _S749 = &points_4[int(2)];
            _S748 = raydir_7;
            break;
        }
        if(_S753 != int(1))
        {
            _S747 = 0.0f;
            break;
        }
        float3  normal_4 = cross_0(*_S752 - *_S751, - (*_S750 - *_S749));
        float3  normal_5;
        if((dot_0(normal_4, normal_4)) != 0.0f)
        {
            normal_5 = normalize_0(normal_4);
        }
        else
        {
            normal_5 = normal_4;
        }
        float3  _S767;
        if((dot_0(gt_normal_0, gt_normal_0)) != 0.0f)
        {
            _S767 = normalize_0(gt_normal_0);
        }
        else
        {
            _S767 = gt_normal_0;
        }
        _S747 = (1.0f - dot_0(normal_5, _S767) + 0.00100000004749745f) / ((F32_max((dot_0(normal_5, - normalize_0(_S748))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S747;
}

struct s_bwd_prop_depth_normal_loss_Intermediates_0
{
    float2  _S768;
    bool _S769;
    float2  _S770;
    bool _S771;
    float2  _S772;
    bool _S773;
    float2  _S774;
    bool _S775;
    float2  _S776;
    bool _S777;
};

inline __device__ void s_bwd_prop_normalize_impl_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_18, float3  _s_dOut_9)
{
    float _S778 = length_0((*dpx_18).primal_0);
    float3  _S779 = (*dpx_18).primal_0 * _s_dOut_9;
    float3  _S780 = make_float3 (1.0f / _S778) * _s_dOut_9;
    float _S781 = - ((_S779.x + _S779.y + _S779.z) / (_S778 * _S778));
    float3  _S782 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S783;
    (&_S783)->primal_0 = (*dpx_18).primal_0;
    (&_S783)->differential_0 = _S782;
    s_bwd_length_impl_0(&_S783, _S781);
    float3  _S784 = _S780 + _S783.differential_0;
    dpx_18->primal_0 = (*dpx_18).primal_0;
    dpx_18->differential_0 = _S784;
    return;
}

inline __device__ void s_bwd_normalize_impl_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S785, float3  _S786)
{
    s_bwd_prop_normalize_impl_0(_S785, _S786);
    return;
}

inline __device__ void depth_normal_loss_vjp_none(float2  pix_center_4, float4  intrins_7, FixedArray<float, 1>  dist_coeffs_11, int camera_model_9, bool is_ray_depth_8, float4  depths_3, float3  gt_normal_1, float v_loss_0, float4  * v_depths_1, float3  * v_gt_normal_0)
{
    float2  _S787 = make_float2 (0.0f);
    s_bwd_prop_depth_normal_loss_Intermediates_0 _S788;
    (&_S788)->_S768 = _S787;
    (&_S788)->_S769 = false;
    (&_S788)->_S770 = _S787;
    (&_S788)->_S771 = false;
    (&_S788)->_S772 = _S787;
    (&_S788)->_S773 = false;
    (&_S788)->_S774 = _S787;
    (&_S788)->_S775 = false;
    (&_S788)->_S776 = _S787;
    (&_S788)->_S777 = false;
    (&_S788)->_S770 = _S787;
    (&_S788)->_S771 = false;
    (&_S788)->_S772 = _S787;
    (&_S788)->_S773 = false;
    (&_S788)->_S774 = _S787;
    (&_S788)->_S775 = false;
    (&_S788)->_S776 = _S787;
    (&_S788)->_S777 = false;
    float2  _S789 = float2 {intrins_7.z, intrins_7.w};
    float2  _S790 = float2 {intrins_7.x, intrins_7.y};
    float2  uv_25 = (pix_center_4 + make_float2 (-1.0f, -0.0f) - _S789) / _S790;
    float2  _S791 = _S787;
    FixedArray<float, 1>  _S792 = dist_coeffs_11;
    bool _S793 = undistort_point_0(uv_25, &_S792, int(12), &_S791);
    (&_S788)->_S768 = _S791;
    (&_S788)->_S769 = _S793;
    bool _S794 = !!_S793;
    bool _runFlag_7;
    if(_S794)
    {
        float2  uv_26 = (pix_center_4 + make_float2 (1.0f, -0.0f) - _S789) / _S790;
        float2  _S795 = _S787;
        FixedArray<float, 1>  _S796 = dist_coeffs_11;
        bool _S797 = undistort_point_0(uv_26, &_S796, int(12), &_S795);
        (&_S788)->_S770 = _S795;
        (&_S788)->_S771 = _S797;
        if(!_S797)
        {
            _runFlag_7 = false;
        }
        else
        {
            _runFlag_7 = _S794;
        }
        if(_runFlag_7)
        {
            float2  uv_27 = (pix_center_4 + make_float2 (0.0f, -1.0f) - _S789) / _S790;
            float2  _S798 = _S787;
            FixedArray<float, 1>  _S799 = dist_coeffs_11;
            bool _S800 = undistort_point_0(uv_27, &_S799, int(12), &_S798);
            (&_S788)->_S772 = _S798;
            (&_S788)->_S773 = _S800;
            if(!_S800)
            {
                _runFlag_7 = false;
            }
            if(_runFlag_7)
            {
                float2  uv_28 = (pix_center_4 + make_float2 (0.0f, 1.0f) - _S789) / _S790;
                float2  _S801 = _S787;
                FixedArray<float, 1>  _S802 = dist_coeffs_11;
                bool _S803 = undistort_point_0(uv_28, &_S802, int(12), &_S801);
                (&_S788)->_S774 = _S801;
                (&_S788)->_S775 = _S803;
                if(!_S803)
                {
                    _runFlag_7 = false;
                }
                if(_runFlag_7)
                {
                    float2  uv_29 = (pix_center_4 - _S789) / _S790;
                    float2  _S804 = _S787;
                    FixedArray<float, 1>  _S805 = dist_coeffs_11;
                    bool _S806 = undistort_point_0(uv_29, &_S805, int(12), &_S804);
                    (&_S788)->_S776 = _S804;
                    (&_S788)->_S777 = _S806;
                }
            }
        }
    }
    s_bwd_prop_depth_normal_loss_Intermediates_0 _S807 = _S788;
    float3  _S808 = make_float3 (0.0f);
    bool _S809 = !!_S788._S769;
    bool _runFlag_8;
    bool _runFlag_9;
    bool _runFlag_10;
    int _S810;
    float3  raydir_8;
    float3  _S811;
    float3  _S812;
    float3  _S813;
    float3  _S814;
    FixedArray<float3 , 5>  points_5;
    if(_S809)
    {
        float3  _S815 = s_primal_ctx_unproject_raydir_0(_S807._S768, camera_model_9, is_ray_depth_8);
        float3  _S816 = make_float3 (depths_3.x) * _S815;
        if(!_S807._S771)
        {
            _runFlag_7 = false;
        }
        else
        {
            _runFlag_7 = _S809;
        }
        if(_runFlag_7)
        {
            float3  _S817 = s_primal_ctx_unproject_raydir_0(_S807._S770, camera_model_9, is_ray_depth_8);
            float3  _S818 = make_float3 (depths_3.y) * _S817;
            if(!_S807._S773)
            {
                _runFlag_8 = false;
            }
            else
            {
                _runFlag_8 = _runFlag_7;
            }
            if(_runFlag_8)
            {
                float3  _S819 = s_primal_ctx_unproject_raydir_0(_S807._S772, camera_model_9, is_ray_depth_8);
                float3  _S820 = make_float3 (depths_3.z) * _S819;
                if(!_S807._S775)
                {
                    _runFlag_9 = false;
                }
                else
                {
                    _runFlag_9 = _runFlag_8;
                }
                if(_runFlag_9)
                {
                    float3  _S821 = s_primal_ctx_unproject_raydir_0(_S807._S774, camera_model_9, is_ray_depth_8);
                    float3  _S822 = make_float3 (depths_3.w) * _S821;
                    if(!_S807._S777)
                    {
                        _runFlag_10 = false;
                    }
                    else
                    {
                        _runFlag_10 = _runFlag_9;
                    }
                    if(_runFlag_10)
                    {
                        float3  _S823 = s_primal_ctx_unproject_raydir_0(_S807._S776, camera_model_9, is_ray_depth_8);
                        _S810 = int(1);
                        raydir_8 = _S823;
                    }
                    else
                    {
                        _S810 = int(0);
                        raydir_8 = _S821;
                    }
                    points_5[int(0)] = _S816;
                    points_5[int(1)] = _S818;
                    points_5[int(2)] = _S820;
                    points_5[int(3)] = _S822;
                    points_5[int(4)] = _S808;
                    _S811 = _S821;
                }
                else
                {
                    _S810 = int(0);
                    raydir_8 = _S819;
                    points_5[int(0)] = _S816;
                    points_5[int(1)] = _S818;
                    points_5[int(2)] = _S820;
                    points_5[int(3)] = _S808;
                    points_5[int(4)] = _S808;
                    _S811 = _S808;
                }
                _S812 = _S819;
            }
            else
            {
                _S810 = int(0);
                raydir_8 = _S817;
                points_5[int(0)] = _S816;
                points_5[int(1)] = _S818;
                points_5[int(2)] = _S808;
                points_5[int(3)] = _S808;
                points_5[int(4)] = _S808;
                _runFlag_9 = false;
                _S811 = _S808;
                _S812 = _S808;
            }
            _S813 = _S817;
        }
        else
        {
            _S810 = int(0);
            raydir_8 = _S815;
            points_5[int(0)] = _S816;
            points_5[int(1)] = _S808;
            points_5[int(2)] = _S808;
            points_5[int(3)] = _S808;
            points_5[int(4)] = _S808;
            _runFlag_8 = false;
            _runFlag_9 = false;
            _S811 = _S808;
            _S812 = _S808;
            _S813 = _S808;
        }
        _S814 = _S815;
    }
    else
    {
        _S810 = int(0);
        points_5[int(0)] = _S808;
        points_5[int(1)] = _S808;
        points_5[int(2)] = _S808;
        points_5[int(3)] = _S808;
        points_5[int(4)] = _S808;
        _runFlag_7 = false;
        _runFlag_8 = false;
        _runFlag_9 = false;
        _S811 = _S808;
        _S812 = _S808;
        _S813 = _S808;
        _S814 = _S808;
    }
    bool _S824 = !(_S810 != int(1));
    bool _S825;
    float3  normal_6;
    float3  _S826;
    float3  _S827;
    float3  _S828;
    float3  _S829;
    float _S830;
    float _S831;
    float _S832;
    float _S833;
    if(_S824)
    {
        float3  dx_2 = points_5[int(1)] - points_5[int(0)];
        float3  _S834 = - (points_5[int(3)] - points_5[int(2)]);
        float3  _S835 = s_primal_ctx_cross_0(dx_2, _S834);
        bool _S836 = (s_primal_ctx_dot_0(_S835, _S835)) != 0.0f;
        if(_S836)
        {
            normal_6 = normalize_0(_S835);
        }
        else
        {
            normal_6 = _S835;
        }
        bool _S837 = (s_primal_ctx_dot_0(gt_normal_1, gt_normal_1)) != 0.0f;
        if(_S837)
        {
            _S826 = normalize_0(gt_normal_1);
        }
        else
        {
            _S826 = gt_normal_1;
        }
        float3  _S838 = - normalize_0(raydir_8);
        float _S839 = s_primal_ctx_dot_0(normal_6, _S838);
        float _S840 = 1.0f - s_primal_ctx_dot_0(normal_6, _S826) + 0.00100000004749745f;
        float _S841 = (F32_max((_S839), (0.0f))) + 0.00100000004749745f;
        _S830 = _S841 * _S841;
        _S831 = _S840;
        _S832 = _S841;
        _S833 = _S839;
        raydir_8 = normal_6;
        normal_6 = _S838;
        _runFlag_10 = _S837;
        _S825 = _S836;
        _S827 = _S835;
        _S828 = dx_2;
        _S829 = _S834;
    }
    else
    {
        _S830 = 0.0f;
        _S831 = 0.0f;
        _S832 = 0.0f;
        _S833 = 0.0f;
        raydir_8 = _S808;
        normal_6 = _S808;
        _S826 = _S808;
        _runFlag_10 = false;
        _S825 = false;
        _S827 = _S808;
        _S828 = _S808;
        _S829 = _S808;
    }
    float4  _S842 = make_float4 (0.0f);
    if(_S824)
    {
        float _S843 = v_loss_0 / _S830;
        float _S844 = _S831 * - _S843;
        float s_diff_num_T_0 = _S832 * _S843;
        DiffPair_float_0 _S845;
        (&_S845)->primal_0 = _S833;
        (&_S845)->differential_0 = 0.0f;
        DiffPair_float_0 _S846;
        (&_S846)->primal_0 = 0.0f;
        (&_S846)->differential_0 = 0.0f;
        _d_max_0(&_S845, &_S846, _S844);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S847;
        (&_S847)->primal_0 = raydir_8;
        (&_S847)->differential_0 = _S808;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S848;
        (&_S848)->primal_0 = normal_6;
        (&_S848)->differential_0 = _S808;
        s_bwd_prop_dot_0(&_S847, &_S848, _S845.differential_0);
        float _S849 = - s_diff_num_T_0;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S850;
        (&_S850)->primal_0 = raydir_8;
        (&_S850)->differential_0 = _S808;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S851;
        (&_S851)->primal_0 = _S826;
        (&_S851)->differential_0 = _S808;
        s_bwd_prop_dot_0(&_S850, &_S851, _S849);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S852 = _S851;
        float3  _S853 = _S847.differential_0 + _S850.differential_0;
        if(_runFlag_10)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S854;
            (&_S854)->primal_0 = gt_normal_1;
            (&_S854)->differential_0 = _S808;
            s_bwd_normalize_impl_0(&_S854, _S852.differential_0);
            raydir_8 = _S854.differential_0;
        }
        else
        {
            raydir_8 = _S852.differential_0;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S855;
        (&_S855)->primal_0 = gt_normal_1;
        (&_S855)->differential_0 = _S808;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S856;
        (&_S856)->primal_0 = gt_normal_1;
        (&_S856)->differential_0 = _S808;
        s_bwd_prop_dot_0(&_S855, &_S856, 0.0f);
        float3  _S857 = _S856.differential_0 + _S855.differential_0 + raydir_8;
        if(_S825)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S858;
            (&_S858)->primal_0 = _S827;
            (&_S858)->differential_0 = _S808;
            s_bwd_normalize_impl_0(&_S858, _S853);
            raydir_8 = _S858.differential_0;
        }
        else
        {
            raydir_8 = _S853;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S859;
        (&_S859)->primal_0 = _S827;
        (&_S859)->differential_0 = _S808;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S860;
        (&_S860)->primal_0 = _S827;
        (&_S860)->differential_0 = _S808;
        s_bwd_prop_dot_0(&_S859, &_S860, 0.0f);
        float3  _S861 = _S860.differential_0 + _S859.differential_0 + raydir_8;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S862;
        (&_S862)->primal_0 = _S828;
        (&_S862)->differential_0 = _S808;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S863;
        (&_S863)->primal_0 = _S829;
        (&_S863)->differential_0 = _S808;
        s_bwd_prop_cross_0(&_S862, &_S863, _S861);
        float3  s_diff_dy_T_2 = - _S863.differential_0;
        float3  _S864 = - s_diff_dy_T_2;
        float3  _S865 = - _S862.differential_0;
        FixedArray<float3 , 5>  _S866;
        _S866[int(0)] = _S808;
        _S866[int(1)] = _S808;
        _S866[int(2)] = _S808;
        _S866[int(3)] = _S808;
        _S866[int(4)] = _S808;
        _S866[int(2)] = _S864;
        _S866[int(3)] = s_diff_dy_T_2;
        _S866[int(0)] = _S865;
        _S866[int(1)] = _S862.differential_0;
        points_5[int(0)] = _S866[int(0)];
        points_5[int(1)] = _S866[int(1)];
        points_5[int(2)] = _S866[int(2)];
        points_5[int(3)] = _S866[int(3)];
        points_5[int(4)] = _S866[int(4)];
        raydir_8 = _S857;
    }
    else
    {
        points_5[int(0)] = _S808;
        points_5[int(1)] = _S808;
        points_5[int(2)] = _S808;
        points_5[int(3)] = _S808;
        points_5[int(4)] = _S808;
        raydir_8 = _S808;
    }
    float4  _S867;
    if(_S809)
    {
        if(_runFlag_7)
        {
            if(_runFlag_8)
            {
                if(_runFlag_9)
                {
                    FixedArray<float3 , 5>  _S868 = points_5;
                    FixedArray<float3 , 5>  _S869 = points_5;
                    FixedArray<float3 , 5>  _S870 = points_5;
                    float3  _S871 = _S811 * points_5[int(3)];
                    float _S872 = _S871.x + _S871.y + _S871.z;
                    float4  _S873 = _S842;
                    *&((&_S873)->w) = _S872;
                    points_5[int(0)] = _S808;
                    points_5[int(1)] = _S808;
                    points_5[int(2)] = _S808;
                    points_5[int(3)] = _S808;
                    points_5[int(4)] = _S808;
                    _S811 = _S870[int(2)];
                    normal_6 = _S868[int(0)];
                    _S826 = _S869[int(1)];
                    _S867 = _S873;
                }
                else
                {
                    FixedArray<float3 , 5>  _S874 = points_5;
                    FixedArray<float3 , 5>  _S875 = points_5;
                    FixedArray<float3 , 5>  _S876 = points_5;
                    FixedArray<float3 , 5>  _S877 = points_5;
                    points_5[int(0)] = points_5[int(0)];
                    points_5[int(1)] = _S874[int(1)];
                    points_5[int(2)] = _S875[int(2)];
                    points_5[int(3)] = _S876[int(3)];
                    points_5[int(4)] = _S877[int(4)];
                    _S811 = _S808;
                    normal_6 = _S808;
                    _S826 = _S808;
                    _S867 = _S842;
                }
                float3  _S878 = _S812 * (points_5[int(2)] + _S811);
                float _S879 = _S878.x + _S878.y + _S878.z;
                float3  _S880 = points_5[int(0)] + normal_6;
                float3  _S881 = points_5[int(1)] + _S826;
                float4  _S882 = _S842;
                *&((&_S882)->z) = _S879;
                float4  _S883 = _S867 + _S882;
                points_5[int(0)] = _S808;
                points_5[int(1)] = _S808;
                points_5[int(2)] = _S808;
                points_5[int(3)] = _S808;
                points_5[int(4)] = _S808;
                _S811 = _S881;
                _S812 = _S880;
                _S867 = _S883;
            }
            else
            {
                FixedArray<float3 , 5>  _S884 = points_5;
                FixedArray<float3 , 5>  _S885 = points_5;
                FixedArray<float3 , 5>  _S886 = points_5;
                FixedArray<float3 , 5>  _S887 = points_5;
                points_5[int(0)] = points_5[int(0)];
                points_5[int(1)] = _S884[int(1)];
                points_5[int(2)] = _S885[int(2)];
                points_5[int(3)] = _S886[int(3)];
                points_5[int(4)] = _S887[int(4)];
                _S811 = _S808;
                _S812 = _S808;
                _S867 = _S842;
            }
            float3  _S888 = _S813 * (points_5[int(1)] + _S811);
            float _S889 = _S888.x + _S888.y + _S888.z;
            float3  _S890 = points_5[int(0)] + _S812;
            float4  _S891 = _S842;
            *&((&_S891)->y) = _S889;
            float4  _S892 = _S867 + _S891;
            points_5[int(0)] = _S808;
            points_5[int(1)] = _S808;
            points_5[int(2)] = _S808;
            points_5[int(3)] = _S808;
            points_5[int(4)] = _S808;
            _S811 = _S890;
            _S867 = _S892;
        }
        else
        {
            FixedArray<float3 , 5>  _S893 = points_5;
            FixedArray<float3 , 5>  _S894 = points_5;
            FixedArray<float3 , 5>  _S895 = points_5;
            FixedArray<float3 , 5>  _S896 = points_5;
            points_5[int(0)] = points_5[int(0)];
            points_5[int(1)] = _S893[int(1)];
            points_5[int(2)] = _S894[int(2)];
            points_5[int(3)] = _S895[int(3)];
            points_5[int(4)] = _S896[int(4)];
            _S811 = _S808;
            _S867 = _S842;
        }
        float3  _S897 = _S814 * (points_5[int(0)] + _S811);
        float _S898 = _S897.x + _S897.y + _S897.z;
        float4  _S899 = _S842;
        *&((&_S899)->x) = _S898;
        _S867 = _S867 + _S899;
    }
    else
    {
        _S867 = _S842;
    }
    *v_depths_1 = _S867;
    *v_gt_normal_0 = raydir_8;
    return;
}

inline __device__ float3  generate_ray_d2n_opencv(float2  pix_pos_3, float4  intrins_8, FixedArray<float, 4>  dist_coeffs_12, int camera_model_10, bool is_ray_depth_9)
{
    float3  _S900;
    for(;;)
    {
        float2  uv_30 = (pix_pos_3 - float2 {intrins_8.z, intrins_8.w}) / float2 {intrins_8.x, intrins_8.y};
        FixedArray<float, 4>  _S901 = dist_coeffs_12;
        float2  uv_u_12;
        bool _S902 = undistort_point_1(uv_30, &_S901, int(12), &uv_u_12);
        if(!_S902)
        {
            int3  _S903 = make_int3 (int(0));
            float3  _S904 = make_float3 ((float)_S903.x, (float)_S903.y, (float)_S903.z);
            _S900 = _S904;
            break;
        }
        _S900 = unproject_raydir_0(uv_u_12, camera_model_10, is_ray_depth_9);
        break;
    }
    return _S900;
}

inline __device__ float3  depth_to_point_opencv(float2  pix_pos_4, float4  intrins_9, FixedArray<float, 4>  dist_coeffs_13, int camera_model_11, bool is_ray_depth_10, float depth_4)
{
    float3  _S905;
    for(;;)
    {
        float2  uv_31 = (pix_pos_4 - float2 {intrins_9.z, intrins_9.w}) / float2 {intrins_9.x, intrins_9.y};
        FixedArray<float, 4>  _S906 = dist_coeffs_13;
        float2  uv_u_13;
        bool _S907 = undistort_point_1(uv_31, &_S906, int(12), &uv_u_13);
        if(!_S907)
        {
            _S905 = make_float3 (0.0f);
            break;
        }
        _S905 = make_float3 (depth_4) * unproject_raydir_0(uv_u_13, camera_model_11, is_ray_depth_10);
        break;
    }
    return _S905;
}

struct s_bwd_prop_depth_to_point_Intermediates_1
{
    float2  _S908;
    bool _S909;
};

inline __device__ float depth_to_point_vjp_opencv(float2  pix_pos_5, float4  intrins_10, FixedArray<float, 4>  dist_coeffs_14, int camera_model_12, bool is_ray_depth_11, float depth_5, float3  v_point_1)
{
    float2  _S910 = make_float2 (0.0f);
    s_bwd_prop_depth_to_point_Intermediates_1 _S911;
    (&_S911)->_S908 = _S910;
    (&_S911)->_S909 = false;
    float2  uv_32 = (pix_pos_5 - float2 {intrins_10.z, intrins_10.w}) / float2 {intrins_10.x, intrins_10.y};
    float2  _S912 = _S910;
    FixedArray<float, 4>  _S913 = dist_coeffs_14;
    bool _S914 = undistort_point_1(uv_32, &_S913, int(12), &_S912);
    (&_S911)->_S908 = _S912;
    (&_S911)->_S909 = _S914;
    s_bwd_prop_depth_to_point_Intermediates_1 _S915 = _S911;
    float3  _S916 = make_float3 (0.0f);
    bool _S917 = !!_S911._S909;
    float3  _S918;
    if(_S917)
    {
        _S918 = s_primal_ctx_unproject_raydir_0(_S915._S908, camera_model_12, is_ray_depth_11);
    }
    else
    {
        _S918 = _S916;
    }
    if(_S917)
    {
        _S918 = _S918 * v_point_1;
    }
    else
    {
        _S918 = _S916;
    }
    return _S918.x + _S918.y + _S918.z;
}

inline __device__ float3  depth_to_normal_opencv(float2  pix_center_5, float4  intrins_11, FixedArray<float, 4>  dist_coeffs_15, int camera_model_13, bool is_ray_depth_12, float4  depths_4)
{
    float3  normal_7;
    for(;;)
    {
        bool _S919;
        if((depths_4.x) == 0.0f)
        {
            _S919 = true;
        }
        else
        {
            _S919 = (depths_4.y) == 0.0f;
        }
        if(_S919)
        {
            _S919 = true;
        }
        else
        {
            _S919 = (depths_4.z) == 0.0f;
        }
        if(_S919)
        {
            _S919 = true;
        }
        else
        {
            _S919 = (depths_4.w) == 0.0f;
        }
        if(_S919)
        {
            normal_7 = make_float3 (0.0f);
            break;
        }
        float3  * _S920;
        float3  * _S921;
        float3  * _S922;
        float3  * _S923;
        int _S924;
        FixedArray<float3 , 4>  points_6;
        for(;;)
        {
            float2  _S925 = float2 {intrins_11.z, intrins_11.w};
            float2  _S926 = float2 {intrins_11.x, intrins_11.y};
            float2  uv_33 = (pix_center_5 + make_float2 (-1.0f, -0.0f) - _S925) / _S926;
            FixedArray<float, 4>  _S927 = dist_coeffs_15;
            float2  uv_u_14;
            bool _S928 = undistort_point_1(uv_33, &_S927, int(12), &uv_u_14);
            if(!_S928)
            {
                float3  _S929 = make_float3 (0.0f);
                _S924 = int(0);
                _S923 = nullptr;
                _S922 = nullptr;
                _S921 = nullptr;
                _S920 = nullptr;
                normal_7 = _S929;
                break;
            }
            points_6[int(0)] = make_float3 (depths_4.x) * unproject_raydir_0(uv_u_14, camera_model_13, is_ray_depth_12);
            for(;;)
            {
                float2  uv_34 = (pix_center_5 + make_float2 (1.0f, -0.0f) - _S925) / _S926;
                FixedArray<float, 4>  _S930 = dist_coeffs_15;
                float2  uv_u_15;
                bool _S931 = undistort_point_1(uv_34, &_S930, int(12), &uv_u_15);
                if(!_S931)
                {
                    float3  _S932 = make_float3 (0.0f);
                    _S924 = int(0);
                    _S923 = nullptr;
                    normal_7 = _S932;
                    break;
                }
                points_6[int(1)] = make_float3 (depths_4.y) * unproject_raydir_0(uv_u_15, camera_model_13, is_ray_depth_12);
                _S924 = int(2);
                _S923 = &points_6[int(1)];
                break;
            }
            if(_S924 != int(2))
            {
                _S922 = &points_6[int(0)];
                _S921 = nullptr;
                _S920 = nullptr;
                break;
            }
            float2  uv_35 = (pix_center_5 + make_float2 (0.0f, -1.0f) - _S925) / _S926;
            FixedArray<float, 4>  _S933 = dist_coeffs_15;
            float2  uv_u_16;
            bool _S934 = undistort_point_1(uv_35, &_S933, int(12), &uv_u_16);
            if(!_S934)
            {
                float3  _S935 = make_float3 (0.0f);
                _S924 = int(0);
                _S922 = &points_6[int(0)];
                _S921 = nullptr;
                _S920 = nullptr;
                normal_7 = _S935;
                break;
            }
            points_6[int(2)] = make_float3 (depths_4.z) * unproject_raydir_0(uv_u_16, camera_model_13, is_ray_depth_12);
            for(;;)
            {
                float2  uv_36 = (pix_center_5 + make_float2 (0.0f, 1.0f) - _S925) / _S926;
                FixedArray<float, 4>  _S936 = dist_coeffs_15;
                float2  uv_u_17;
                bool _S937 = undistort_point_1(uv_36, &_S936, int(12), &uv_u_17);
                if(!_S937)
                {
                    float3  _S938 = make_float3 (0.0f);
                    _S924 = int(0);
                    _S922 = nullptr;
                    normal_7 = _S938;
                    break;
                }
                points_6[int(3)] = make_float3 (depths_4.w) * unproject_raydir_0(uv_u_17, camera_model_13, is_ray_depth_12);
                _S924 = int(2);
                _S922 = &points_6[int(3)];
                break;
            }
            if(_S924 != int(2))
            {
                float3  * _S939 = _S922;
                _S922 = &points_6[int(0)];
                _S921 = _S939;
                _S920 = &points_6[int(2)];
                break;
            }
            float3  * _S940 = _S922;
            _S924 = int(1);
            _S922 = &points_6[int(0)];
            _S921 = _S940;
            _S920 = &points_6[int(2)];
            break;
        }
        if(_S924 != int(1))
        {
            break;
        }
        float3  normal_8 = cross_0(*_S923 - *_S922, - (*_S921 - *_S920));
        if((dot_0(normal_8, normal_8)) != 0.0f)
        {
            normal_7 = normal_8 / make_float3 (length_0(normal_8));
        }
        else
        {
            normal_7 = normal_8;
        }
        break;
    }
    return normal_7;
}

struct s_bwd_prop_depth_to_normal_Intermediates_1
{
    float2  _S941;
    bool _S942;
    float2  _S943;
    bool _S944;
    float2  _S945;
    bool _S946;
    float2  _S947;
    bool _S948;
};

inline __device__ void depth_to_normal_vjp_opencv(float2  pix_center_6, float4  intrins_12, FixedArray<float, 4>  dist_coeffs_16, int camera_model_14, bool is_ray_depth_13, float4  depths_5, float3  v_normal_2, float4  * v_depths_2)
{
    float2  _S949 = make_float2 (0.0f);
    s_bwd_prop_depth_to_normal_Intermediates_1 _S950;
    (&_S950)->_S941 = _S949;
    (&_S950)->_S942 = false;
    (&_S950)->_S943 = _S949;
    (&_S950)->_S944 = false;
    (&_S950)->_S945 = _S949;
    (&_S950)->_S946 = false;
    (&_S950)->_S947 = _S949;
    (&_S950)->_S948 = false;
    (&_S950)->_S941 = _S949;
    (&_S950)->_S942 = false;
    (&_S950)->_S943 = _S949;
    (&_S950)->_S944 = false;
    (&_S950)->_S945 = _S949;
    (&_S950)->_S946 = false;
    (&_S950)->_S947 = _S949;
    (&_S950)->_S948 = false;
    bool _S951 = (depths_5.x) == 0.0f;
    bool _runFlag_11;
    if(_S951)
    {
        _runFlag_11 = true;
    }
    else
    {
        _runFlag_11 = (depths_5.y) == 0.0f;
    }
    if(_runFlag_11)
    {
        _runFlag_11 = true;
    }
    else
    {
        _runFlag_11 = (depths_5.z) == 0.0f;
    }
    if(_runFlag_11)
    {
        _runFlag_11 = true;
    }
    else
    {
        _runFlag_11 = (depths_5.w) == 0.0f;
    }
    int _S952;
    if(!_runFlag_11)
    {
        float2  _S953 = float2 {intrins_12.z, intrins_12.w};
        float2  _S954 = float2 {intrins_12.x, intrins_12.y};
        float2  uv_37 = (pix_center_6 + make_float2 (-1.0f, -0.0f) - _S953) / _S954;
        float2  _S955 = _S949;
        FixedArray<float, 4>  _S956 = dist_coeffs_16;
        bool _S957 = undistort_point_1(uv_37, &_S956, int(12), &_S955);
        (&_S950)->_S941 = _S955;
        (&_S950)->_S942 = _S957;
        bool _S958 = !!_S957;
        if(_S958)
        {
            float2  uv_38 = (pix_center_6 + make_float2 (1.0f, -0.0f) - _S953) / _S954;
            float2  _S959 = _S949;
            FixedArray<float, 4>  _S960 = dist_coeffs_16;
            bool _S961 = undistort_point_1(uv_38, &_S960, int(12), &_S959);
            (&_S950)->_S943 = _S959;
            (&_S950)->_S944 = _S961;
            if(!!_S961)
            {
                _S952 = int(2);
            }
            else
            {
                _S952 = int(0);
            }
            if(_S952 != int(2))
            {
                _runFlag_11 = false;
            }
            else
            {
                _runFlag_11 = _S958;
            }
            if(_runFlag_11)
            {
                float2  uv_39 = (pix_center_6 + make_float2 (0.0f, -1.0f) - _S953) / _S954;
                float2  _S962 = _S949;
                FixedArray<float, 4>  _S963 = dist_coeffs_16;
                bool _S964 = undistort_point_1(uv_39, &_S963, int(12), &_S962);
                (&_S950)->_S945 = _S962;
                (&_S950)->_S946 = _S964;
                if(!_S964)
                {
                    _runFlag_11 = false;
                }
                if(_runFlag_11)
                {
                    float2  uv_40 = (pix_center_6 + make_float2 (0.0f, 1.0f) - _S953) / _S954;
                    float2  _S965 = _S949;
                    FixedArray<float, 4>  _S966 = dist_coeffs_16;
                    bool _S967 = undistort_point_1(uv_40, &_S966, int(12), &_S965);
                    (&_S950)->_S947 = _S965;
                    (&_S950)->_S948 = _S967;
                }
            }
        }
    }
    s_bwd_prop_depth_to_normal_Intermediates_1 _S968 = _S950;
    float3  _S969 = make_float3 (0.0f);
    if(_S951)
    {
        _runFlag_11 = true;
    }
    else
    {
        _runFlag_11 = (depths_5.y) == 0.0f;
    }
    if(_runFlag_11)
    {
        _runFlag_11 = true;
    }
    else
    {
        _runFlag_11 = (depths_5.z) == 0.0f;
    }
    if(_runFlag_11)
    {
        _runFlag_11 = true;
    }
    else
    {
        _runFlag_11 = (depths_5.w) == 0.0f;
    }
    bool _S970 = !_runFlag_11;
    bool _runFlag_12;
    bool _runFlag_13;
    bool _S971;
    bool _runFlag_14;
    bool _S972;
    bool _S973;
    FixedArray<float3 , 4>  points_7;
    float3  _S974;
    float3  _S975;
    float3  _S976;
    float3  _S977;
    float3  _S978;
    float3  _S979;
    float3  _S980;
    float3  _S981;
    float3  _S982;
    if(_S970)
    {
        bool _S983 = !!_S968._S942;
        if(_S983)
        {
            float3  _S984 = s_primal_ctx_unproject_raydir_0(_S968._S941, camera_model_14, is_ray_depth_13);
            float3  _S985 = make_float3 (depths_5.x) * _S984;
            bool _S986 = !!_S968._S944;
            if(_S986)
            {
                float3  _S987 = s_primal_ctx_unproject_raydir_0(_S968._S943, camera_model_14, is_ray_depth_13);
                float3  _S988 = make_float3 (depths_5.y) * _S987;
                _S952 = int(2);
                points_7[int(0)] = _S985;
                points_7[int(1)] = _S988;
                points_7[int(2)] = _S969;
                points_7[int(3)] = _S969;
                _S974 = _S987;
            }
            else
            {
                _S952 = int(0);
                points_7[int(0)] = _S985;
                points_7[int(1)] = _S969;
                points_7[int(2)] = _S969;
                points_7[int(3)] = _S969;
                _S974 = _S969;
            }
            if(_S952 != int(2))
            {
                _runFlag_11 = false;
            }
            else
            {
                _runFlag_11 = _S983;
                _S952 = int(0);
            }
            if(_runFlag_11)
            {
                if(!_S968._S946)
                {
                    _runFlag_12 = false;
                    _S952 = int(0);
                }
                else
                {
                    _runFlag_12 = _runFlag_11;
                }
                if(_runFlag_12)
                {
                    float3  _S989 = s_primal_ctx_unproject_raydir_0(_S968._S945, camera_model_14, is_ray_depth_13);
                    points_7[int(2)] = make_float3 (depths_5.z) * _S989;
                    bool _S990 = !!_S968._S948;
                    int _S991;
                    if(_S990)
                    {
                        float3  _S992 = s_primal_ctx_unproject_raydir_0(_S968._S947, camera_model_14, is_ray_depth_13);
                        points_7[int(3)] = make_float3 (depths_5.w) * _S992;
                        _S991 = int(2);
                        _S975 = _S992;
                    }
                    else
                    {
                        _S991 = int(0);
                        _S975 = _S969;
                    }
                    if(_S991 != int(2))
                    {
                        _runFlag_13 = false;
                        _S952 = _S991;
                    }
                    else
                    {
                        _runFlag_13 = _runFlag_12;
                    }
                    if(_runFlag_13)
                    {
                        _S952 = int(1);
                    }
                    _runFlag_13 = _S990;
                    _S976 = _S989;
                }
                else
                {
                    _runFlag_13 = false;
                    _S975 = _S969;
                    _S976 = _S969;
                }
            }
            else
            {
                _runFlag_12 = false;
                _runFlag_13 = false;
                _S975 = _S969;
                _S976 = _S969;
            }
            float3  _S993 = _S974;
            _S974 = _S975;
            _S975 = _S976;
            _S971 = _S986;
            _S976 = _S993;
            _S977 = _S984;
        }
        else
        {
            _S952 = int(0);
            points_7[int(0)] = _S969;
            points_7[int(1)] = _S969;
            points_7[int(2)] = _S969;
            points_7[int(3)] = _S969;
            _runFlag_11 = false;
            _runFlag_12 = false;
            _runFlag_13 = false;
            _S974 = _S969;
            _S975 = _S969;
            _S971 = false;
            _S976 = _S969;
            _S977 = _S969;
        }
        if(_S952 != int(1))
        {
            _runFlag_14 = false;
        }
        else
        {
            _runFlag_14 = _S970;
        }
        if(_runFlag_14)
        {
            float3  dx_3 = points_7[int(1)] - points_7[int(0)];
            float3  _S994 = - (points_7[int(3)] - points_7[int(2)]);
            float3  _S995 = s_primal_ctx_cross_0(dx_3, _S994);
            bool _S996 = (s_primal_ctx_dot_0(_S995, _S995)) != 0.0f;
            if(_S996)
            {
                float _S997 = length_0(_S995);
                float3  _S998 = make_float3 (_S997);
                _S978 = make_float3 (_S997 * _S997);
                _S979 = _S998;
            }
            else
            {
                _S978 = _S969;
                _S979 = _S969;
            }
            float3  _S999 = _S979;
            _S972 = _S996;
            _S979 = _S995;
            _S980 = _S999;
            _S981 = dx_3;
            _S982 = _S994;
        }
        else
        {
            _S972 = false;
            _S978 = _S969;
            _S979 = _S969;
            _S980 = _S969;
            _S981 = _S969;
            _S982 = _S969;
        }
        bool _S1000 = _runFlag_11;
        bool _S1001 = _runFlag_12;
        bool _S1002 = _runFlag_13;
        float3  _S1003 = _S974;
        float3  _S1004 = _S975;
        bool _S1005 = _S971;
        float3  _S1006 = _S976;
        float3  _S1007 = _S977;
        _runFlag_11 = _runFlag_14;
        _runFlag_12 = _S972;
        _S974 = _S978;
        _S975 = _S979;
        _S976 = _S980;
        _S977 = _S981;
        _S978 = _S982;
        _runFlag_13 = _S983;
        _S971 = _S1000;
        _runFlag_14 = _S1001;
        _S972 = _S1002;
        _S979 = _S1003;
        _S980 = _S1004;
        _S973 = _S1005;
        _S981 = _S1006;
        _S982 = _S1007;
    }
    else
    {
        _runFlag_11 = false;
        _runFlag_12 = false;
        _S974 = _S969;
        _S975 = _S969;
        _S976 = _S969;
        _S977 = _S969;
        _S978 = _S969;
        _runFlag_13 = false;
        _S971 = false;
        _runFlag_14 = false;
        _S972 = false;
        _S979 = _S969;
        _S980 = _S969;
        _S973 = false;
        _S981 = _S969;
        _S982 = _S969;
    }
    float4  _S1008 = make_float4 (0.0f);
    float4  _S1009;
    if(_S970)
    {
        if(_runFlag_11)
        {
            if(_runFlag_12)
            {
                float3  _S1010 = v_normal_2 / _S974;
                float3  _S1011 = _S975 * - _S1010;
                float3  _S1012 = _S976 * _S1010;
                float _S1013 = _S1011.x + _S1011.y + _S1011.z;
                DiffPair_vectorx3Cfloatx2C3x3E_0 _S1014;
                (&_S1014)->primal_0 = _S975;
                (&_S1014)->differential_0 = _S969;
                s_bwd_length_impl_0(&_S1014, _S1013);
                _S974 = _S1012 + _S1014.differential_0;
            }
            else
            {
                _S974 = v_normal_2;
            }
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1015;
            (&_S1015)->primal_0 = _S975;
            (&_S1015)->differential_0 = _S969;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1016;
            (&_S1016)->primal_0 = _S975;
            (&_S1016)->differential_0 = _S969;
            s_bwd_prop_dot_0(&_S1015, &_S1016, 0.0f);
            float3  _S1017 = _S1016.differential_0 + _S1015.differential_0 + _S974;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1018;
            (&_S1018)->primal_0 = _S977;
            (&_S1018)->differential_0 = _S969;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1019;
            (&_S1019)->primal_0 = _S978;
            (&_S1019)->differential_0 = _S969;
            s_bwd_prop_cross_0(&_S1018, &_S1019, _S1017);
            float3  s_diff_dy_T_3 = - _S1019.differential_0;
            float3  _S1020 = - s_diff_dy_T_3;
            float3  _S1021 = - _S1018.differential_0;
            FixedArray<float3 , 4>  _S1022;
            _S1022[int(0)] = _S969;
            _S1022[int(1)] = _S969;
            _S1022[int(2)] = _S969;
            _S1022[int(3)] = _S969;
            _S1022[int(2)] = _S1020;
            _S1022[int(3)] = s_diff_dy_T_3;
            _S1022[int(0)] = _S1021;
            _S1022[int(1)] = _S1018.differential_0;
            points_7[int(0)] = _S1022[int(0)];
            points_7[int(1)] = _S1022[int(1)];
            points_7[int(2)] = _S1022[int(2)];
            points_7[int(3)] = _S1022[int(3)];
        }
        else
        {
            points_7[int(0)] = _S969;
            points_7[int(1)] = _S969;
            points_7[int(2)] = _S969;
            points_7[int(3)] = _S969;
        }
        if(_runFlag_13)
        {
            if(_S971)
            {
                if(_runFlag_14)
                {
                    FixedArray<float3 , 4>  _S1023 = points_7;
                    FixedArray<float3 , 4>  _S1024 = points_7;
                    FixedArray<float3 , 4>  _S1025 = points_7;
                    FixedArray<float3 , 4>  _S1026 = points_7;
                    if(_S972)
                    {
                        float3  _S1027 = _S979 * _S1026[int(3)];
                        float _S1028 = _S1027.x + _S1027.y + _S1027.z;
                        float4  _S1029 = _S1008;
                        *&((&_S1029)->w) = _S1028;
                        points_7[int(0)] = _S1023[int(0)];
                        points_7[int(1)] = _S1024[int(1)];
                        points_7[int(2)] = _S1025[int(2)];
                        points_7[int(3)] = _S969;
                        _S1009 = _S1029;
                    }
                    else
                    {
                        points_7[int(0)] = _S1023[int(0)];
                        points_7[int(1)] = _S1024[int(1)];
                        points_7[int(2)] = _S1025[int(2)];
                        points_7[int(3)] = _S1026[int(3)];
                        _S1009 = _S1008;
                    }
                    float3  _S1030 = _S980 * points_7[int(2)];
                    float _S1031 = _S1030.x + _S1030.y + _S1030.z;
                    FixedArray<float3 , 4>  _S1032 = points_7;
                    FixedArray<float3 , 4>  _S1033 = points_7;
                    float4  _S1034 = _S1008;
                    *&((&_S1034)->z) = _S1031;
                    float4  _S1035 = _S1009 + _S1034;
                    points_7[int(0)] = points_7[int(0)];
                    points_7[int(1)] = _S1032[int(1)];
                    points_7[int(2)] = _S969;
                    points_7[int(3)] = _S1033[int(3)];
                    _S1009 = _S1035;
                }
                else
                {
                    FixedArray<float3 , 4>  _S1036 = points_7;
                    FixedArray<float3 , 4>  _S1037 = points_7;
                    FixedArray<float3 , 4>  _S1038 = points_7;
                    points_7[int(0)] = points_7[int(0)];
                    points_7[int(1)] = _S1036[int(1)];
                    points_7[int(2)] = _S1037[int(2)];
                    points_7[int(3)] = _S1038[int(3)];
                    _S1009 = _S1008;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S1039 = points_7;
                FixedArray<float3 , 4>  _S1040 = points_7;
                FixedArray<float3 , 4>  _S1041 = points_7;
                points_7[int(0)] = points_7[int(0)];
                points_7[int(1)] = _S1039[int(1)];
                points_7[int(2)] = _S1040[int(2)];
                points_7[int(3)] = _S1041[int(3)];
                _S1009 = _S1008;
            }
            if(_S973)
            {
                FixedArray<float3 , 4>  _S1042 = points_7;
                float3  _S1043 = _S981 * points_7[int(1)];
                float _S1044 = _S1043.x + _S1043.y + _S1043.z;
                float4  _S1045 = _S1008;
                *&((&_S1045)->y) = _S1044;
                float4  _S1046 = _S1009 + _S1045;
                points_7[int(0)] = _S969;
                points_7[int(1)] = _S969;
                points_7[int(2)] = _S969;
                points_7[int(3)] = _S969;
                _S974 = _S1042[int(0)];
                _S1009 = _S1046;
            }
            else
            {
                FixedArray<float3 , 4>  _S1047 = points_7;
                FixedArray<float3 , 4>  _S1048 = points_7;
                FixedArray<float3 , 4>  _S1049 = points_7;
                points_7[int(0)] = points_7[int(0)];
                points_7[int(1)] = _S1047[int(1)];
                points_7[int(2)] = _S1048[int(2)];
                points_7[int(3)] = _S1049[int(3)];
                _S974 = _S969;
            }
            float3  _S1050 = _S982 * (points_7[int(0)] + _S974);
            float _S1051 = _S1050.x + _S1050.y + _S1050.z;
            float4  _S1052 = _S1008;
            *&((&_S1052)->x) = _S1051;
            _S1009 = _S1009 + _S1052;
        }
        else
        {
            _S1009 = _S1008;
        }
    }
    else
    {
        _S1009 = _S1008;
    }
    *v_depths_2 = _S1009;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_opencv(float2  pix_center_7, float4  intrins_13, FixedArray<float, 4>  dist_coeffs_17, int camera_model_15)
{
    float _S1053;
    for(;;)
    {
        float2  uv_41 = (pix_center_7 - float2 {intrins_13.z, intrins_13.w}) / float2 {intrins_13.x, intrins_13.y};
        FixedArray<float, 4>  _S1054 = dist_coeffs_17;
        float2  uv_u_18;
        bool _S1055 = undistort_point_1(uv_41, &_S1054, int(12), &uv_u_18);
        if(!_S1055)
        {
            _S1053 = 0.0f;
            break;
        }
        float3  raydir_9 = unproject_raydir_0(uv_u_18, camera_model_15, false);
        _S1053 = float((F32_sign((raydir_9.z)))) / length_0(raydir_9);
        break;
    }
    return _S1053;
}

inline __device__ float depth_normal_loss_opencv(float2  pix_center_8, float4  intrins_14, FixedArray<float, 4>  dist_coeffs_18, int camera_model_16, bool is_ray_depth_14, float4  depths_6, float3  gt_normal_2)
{
    float _S1056;
    for(;;)
    {
        float3  _S1057;
        float3  * _S1058;
        float3  * _S1059;
        float3  * _S1060;
        float3  * _S1061;
        int _S1062;
        FixedArray<float3 , 5>  points_8;
        for(;;)
        {
            float2  _S1063 = float2 {intrins_14.z, intrins_14.w};
            float2  _S1064 = float2 {intrins_14.x, intrins_14.y};
            float2  uv_42 = (pix_center_8 + make_float2 (-1.0f, -0.0f) - _S1063) / _S1064;
            FixedArray<float, 4>  _S1065 = dist_coeffs_18;
            float2  uv_u_19;
            bool _S1066 = undistort_point_1(uv_42, &_S1065, int(12), &uv_u_19);
            float3  _S1067 = make_float3 (0.0f);
            if(!_S1066)
            {
                _S1062 = int(0);
                _S1061 = nullptr;
                _S1060 = nullptr;
                _S1059 = nullptr;
                _S1058 = nullptr;
                _S1057 = _S1067;
                break;
            }
            float3  raydir_10 = unproject_raydir_0(uv_u_19, camera_model_16, is_ray_depth_14);
            points_8[int(0)] = make_float3 (depths_6.x) * raydir_10;
            float2  uv_43 = (pix_center_8 + make_float2 (1.0f, -0.0f) - _S1063) / _S1064;
            FixedArray<float, 4>  _S1068 = dist_coeffs_18;
            float2  uv_u_20;
            bool _S1069 = undistort_point_1(uv_43, &_S1068, int(12), &uv_u_20);
            if(!_S1069)
            {
                _S1062 = int(0);
                _S1061 = nullptr;
                _S1060 = &points_8[int(0)];
                _S1059 = nullptr;
                _S1058 = nullptr;
                _S1057 = _S1067;
                break;
            }
            float3  raydir_11 = unproject_raydir_0(uv_u_20, camera_model_16, is_ray_depth_14);
            points_8[int(1)] = make_float3 (depths_6.y) * raydir_11;
            float2  uv_44 = (pix_center_8 + make_float2 (0.0f, -1.0f) - _S1063) / _S1064;
            FixedArray<float, 4>  _S1070 = dist_coeffs_18;
            float2  uv_u_21;
            bool _S1071 = undistort_point_1(uv_44, &_S1070, int(12), &uv_u_21);
            if(!_S1071)
            {
                _S1062 = int(0);
                _S1061 = &points_8[int(1)];
                _S1060 = &points_8[int(0)];
                _S1059 = nullptr;
                _S1058 = nullptr;
                _S1057 = _S1067;
                break;
            }
            float3  raydir_12 = unproject_raydir_0(uv_u_21, camera_model_16, is_ray_depth_14);
            points_8[int(2)] = make_float3 (depths_6.z) * raydir_12;
            float2  uv_45 = (pix_center_8 + make_float2 (0.0f, 1.0f) - _S1063) / _S1064;
            FixedArray<float, 4>  _S1072 = dist_coeffs_18;
            float2  uv_u_22;
            bool _S1073 = undistort_point_1(uv_45, &_S1072, int(12), &uv_u_22);
            if(!_S1073)
            {
                _S1062 = int(0);
                _S1061 = &points_8[int(1)];
                _S1060 = &points_8[int(0)];
                _S1059 = nullptr;
                _S1058 = &points_8[int(2)];
                _S1057 = _S1067;
                break;
            }
            float3  raydir_13 = unproject_raydir_0(uv_u_22, camera_model_16, is_ray_depth_14);
            points_8[int(3)] = make_float3 (depths_6.w) * raydir_13;
            float2  uv_46 = (pix_center_8 + make_float2 (0.0f) * make_float2 (0.0f, 3.0f) - _S1063) / _S1064;
            FixedArray<float, 4>  _S1074 = dist_coeffs_18;
            float2  uv_u_23;
            bool _S1075 = undistort_point_1(uv_46, &_S1074, int(12), &uv_u_23);
            if(!_S1075)
            {
                _S1062 = int(0);
                _S1061 = &points_8[int(1)];
                _S1060 = &points_8[int(0)];
                _S1059 = &points_8[int(3)];
                _S1058 = &points_8[int(2)];
                _S1057 = _S1067;
                break;
            }
            float3  raydir_14 = unproject_raydir_0(uv_u_23, camera_model_16, is_ray_depth_14);
            _S1062 = int(1);
            _S1061 = &points_8[int(1)];
            _S1060 = &points_8[int(0)];
            _S1059 = &points_8[int(3)];
            _S1058 = &points_8[int(2)];
            _S1057 = raydir_14;
            break;
        }
        if(_S1062 != int(1))
        {
            _S1056 = 0.0f;
            break;
        }
        float3  normal_9 = cross_0(*_S1061 - *_S1060, - (*_S1059 - *_S1058));
        float3  normal_10;
        if((dot_0(normal_9, normal_9)) != 0.0f)
        {
            normal_10 = normalize_0(normal_9);
        }
        else
        {
            normal_10 = normal_9;
        }
        float3  _S1076;
        if((dot_0(gt_normal_2, gt_normal_2)) != 0.0f)
        {
            _S1076 = normalize_0(gt_normal_2);
        }
        else
        {
            _S1076 = gt_normal_2;
        }
        _S1056 = (1.0f - dot_0(normal_10, _S1076) + 0.00100000004749745f) / ((F32_max((dot_0(normal_10, - normalize_0(_S1057))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S1056;
}

struct s_bwd_prop_depth_normal_loss_Intermediates_1
{
    float2  _S1077;
    bool _S1078;
    float2  _S1079;
    bool _S1080;
    float2  _S1081;
    bool _S1082;
    float2  _S1083;
    bool _S1084;
    float2  _S1085;
    bool _S1086;
};

inline __device__ void depth_normal_loss_vjp_opencv(float2  pix_center_9, float4  intrins_15, FixedArray<float, 4>  dist_coeffs_19, int camera_model_17, bool is_ray_depth_15, float4  depths_7, float3  gt_normal_3, float v_loss_1, float4  * v_depths_3, float3  * v_gt_normal_1)
{
    float2  _S1087 = make_float2 (0.0f);
    s_bwd_prop_depth_normal_loss_Intermediates_1 _S1088;
    (&_S1088)->_S1077 = _S1087;
    (&_S1088)->_S1078 = false;
    (&_S1088)->_S1079 = _S1087;
    (&_S1088)->_S1080 = false;
    (&_S1088)->_S1081 = _S1087;
    (&_S1088)->_S1082 = false;
    (&_S1088)->_S1083 = _S1087;
    (&_S1088)->_S1084 = false;
    (&_S1088)->_S1085 = _S1087;
    (&_S1088)->_S1086 = false;
    (&_S1088)->_S1079 = _S1087;
    (&_S1088)->_S1080 = false;
    (&_S1088)->_S1081 = _S1087;
    (&_S1088)->_S1082 = false;
    (&_S1088)->_S1083 = _S1087;
    (&_S1088)->_S1084 = false;
    (&_S1088)->_S1085 = _S1087;
    (&_S1088)->_S1086 = false;
    float2  _S1089 = float2 {intrins_15.z, intrins_15.w};
    float2  _S1090 = float2 {intrins_15.x, intrins_15.y};
    float2  uv_47 = (pix_center_9 + make_float2 (-1.0f, -0.0f) - _S1089) / _S1090;
    float2  _S1091 = _S1087;
    FixedArray<float, 4>  _S1092 = dist_coeffs_19;
    bool _S1093 = undistort_point_1(uv_47, &_S1092, int(12), &_S1091);
    (&_S1088)->_S1077 = _S1091;
    (&_S1088)->_S1078 = _S1093;
    bool _S1094 = !!_S1093;
    bool _runFlag_15;
    if(_S1094)
    {
        float2  uv_48 = (pix_center_9 + make_float2 (1.0f, -0.0f) - _S1089) / _S1090;
        float2  _S1095 = _S1087;
        FixedArray<float, 4>  _S1096 = dist_coeffs_19;
        bool _S1097 = undistort_point_1(uv_48, &_S1096, int(12), &_S1095);
        (&_S1088)->_S1079 = _S1095;
        (&_S1088)->_S1080 = _S1097;
        if(!_S1097)
        {
            _runFlag_15 = false;
        }
        else
        {
            _runFlag_15 = _S1094;
        }
        if(_runFlag_15)
        {
            float2  uv_49 = (pix_center_9 + make_float2 (0.0f, -1.0f) - _S1089) / _S1090;
            float2  _S1098 = _S1087;
            FixedArray<float, 4>  _S1099 = dist_coeffs_19;
            bool _S1100 = undistort_point_1(uv_49, &_S1099, int(12), &_S1098);
            (&_S1088)->_S1081 = _S1098;
            (&_S1088)->_S1082 = _S1100;
            if(!_S1100)
            {
                _runFlag_15 = false;
            }
            if(_runFlag_15)
            {
                float2  uv_50 = (pix_center_9 + make_float2 (0.0f, 1.0f) - _S1089) / _S1090;
                float2  _S1101 = _S1087;
                FixedArray<float, 4>  _S1102 = dist_coeffs_19;
                bool _S1103 = undistort_point_1(uv_50, &_S1102, int(12), &_S1101);
                (&_S1088)->_S1083 = _S1101;
                (&_S1088)->_S1084 = _S1103;
                if(!_S1103)
                {
                    _runFlag_15 = false;
                }
                if(_runFlag_15)
                {
                    float2  uv_51 = (pix_center_9 - _S1089) / _S1090;
                    float2  _S1104 = _S1087;
                    FixedArray<float, 4>  _S1105 = dist_coeffs_19;
                    bool _S1106 = undistort_point_1(uv_51, &_S1105, int(12), &_S1104);
                    (&_S1088)->_S1085 = _S1104;
                    (&_S1088)->_S1086 = _S1106;
                }
            }
        }
    }
    s_bwd_prop_depth_normal_loss_Intermediates_1 _S1107 = _S1088;
    float3  _S1108 = make_float3 (0.0f);
    bool _S1109 = !!_S1088._S1078;
    bool _runFlag_16;
    bool _runFlag_17;
    bool _runFlag_18;
    int _S1110;
    float3  raydir_15;
    float3  _S1111;
    float3  _S1112;
    float3  _S1113;
    float3  _S1114;
    FixedArray<float3 , 5>  points_9;
    if(_S1109)
    {
        float3  _S1115 = s_primal_ctx_unproject_raydir_0(_S1107._S1077, camera_model_17, is_ray_depth_15);
        float3  _S1116 = make_float3 (depths_7.x) * _S1115;
        if(!_S1107._S1080)
        {
            _runFlag_15 = false;
        }
        else
        {
            _runFlag_15 = _S1109;
        }
        if(_runFlag_15)
        {
            float3  _S1117 = s_primal_ctx_unproject_raydir_0(_S1107._S1079, camera_model_17, is_ray_depth_15);
            float3  _S1118 = make_float3 (depths_7.y) * _S1117;
            if(!_S1107._S1082)
            {
                _runFlag_16 = false;
            }
            else
            {
                _runFlag_16 = _runFlag_15;
            }
            if(_runFlag_16)
            {
                float3  _S1119 = s_primal_ctx_unproject_raydir_0(_S1107._S1081, camera_model_17, is_ray_depth_15);
                float3  _S1120 = make_float3 (depths_7.z) * _S1119;
                if(!_S1107._S1084)
                {
                    _runFlag_17 = false;
                }
                else
                {
                    _runFlag_17 = _runFlag_16;
                }
                if(_runFlag_17)
                {
                    float3  _S1121 = s_primal_ctx_unproject_raydir_0(_S1107._S1083, camera_model_17, is_ray_depth_15);
                    float3  _S1122 = make_float3 (depths_7.w) * _S1121;
                    if(!_S1107._S1086)
                    {
                        _runFlag_18 = false;
                    }
                    else
                    {
                        _runFlag_18 = _runFlag_17;
                    }
                    if(_runFlag_18)
                    {
                        float3  _S1123 = s_primal_ctx_unproject_raydir_0(_S1107._S1085, camera_model_17, is_ray_depth_15);
                        _S1110 = int(1);
                        raydir_15 = _S1123;
                    }
                    else
                    {
                        _S1110 = int(0);
                        raydir_15 = _S1121;
                    }
                    points_9[int(0)] = _S1116;
                    points_9[int(1)] = _S1118;
                    points_9[int(2)] = _S1120;
                    points_9[int(3)] = _S1122;
                    points_9[int(4)] = _S1108;
                    _S1111 = _S1121;
                }
                else
                {
                    _S1110 = int(0);
                    raydir_15 = _S1119;
                    points_9[int(0)] = _S1116;
                    points_9[int(1)] = _S1118;
                    points_9[int(2)] = _S1120;
                    points_9[int(3)] = _S1108;
                    points_9[int(4)] = _S1108;
                    _S1111 = _S1108;
                }
                _S1112 = _S1119;
            }
            else
            {
                _S1110 = int(0);
                raydir_15 = _S1117;
                points_9[int(0)] = _S1116;
                points_9[int(1)] = _S1118;
                points_9[int(2)] = _S1108;
                points_9[int(3)] = _S1108;
                points_9[int(4)] = _S1108;
                _runFlag_17 = false;
                _S1111 = _S1108;
                _S1112 = _S1108;
            }
            _S1113 = _S1117;
        }
        else
        {
            _S1110 = int(0);
            raydir_15 = _S1115;
            points_9[int(0)] = _S1116;
            points_9[int(1)] = _S1108;
            points_9[int(2)] = _S1108;
            points_9[int(3)] = _S1108;
            points_9[int(4)] = _S1108;
            _runFlag_16 = false;
            _runFlag_17 = false;
            _S1111 = _S1108;
            _S1112 = _S1108;
            _S1113 = _S1108;
        }
        _S1114 = _S1115;
    }
    else
    {
        _S1110 = int(0);
        points_9[int(0)] = _S1108;
        points_9[int(1)] = _S1108;
        points_9[int(2)] = _S1108;
        points_9[int(3)] = _S1108;
        points_9[int(4)] = _S1108;
        _runFlag_15 = false;
        _runFlag_16 = false;
        _runFlag_17 = false;
        _S1111 = _S1108;
        _S1112 = _S1108;
        _S1113 = _S1108;
        _S1114 = _S1108;
    }
    bool _S1124 = !(_S1110 != int(1));
    bool _S1125;
    float3  normal_11;
    float3  _S1126;
    float3  _S1127;
    float3  _S1128;
    float3  _S1129;
    float _S1130;
    float _S1131;
    float _S1132;
    float _S1133;
    if(_S1124)
    {
        float3  dx_4 = points_9[int(1)] - points_9[int(0)];
        float3  _S1134 = - (points_9[int(3)] - points_9[int(2)]);
        float3  _S1135 = s_primal_ctx_cross_0(dx_4, _S1134);
        bool _S1136 = (s_primal_ctx_dot_0(_S1135, _S1135)) != 0.0f;
        if(_S1136)
        {
            normal_11 = normalize_0(_S1135);
        }
        else
        {
            normal_11 = _S1135;
        }
        bool _S1137 = (s_primal_ctx_dot_0(gt_normal_3, gt_normal_3)) != 0.0f;
        if(_S1137)
        {
            _S1126 = normalize_0(gt_normal_3);
        }
        else
        {
            _S1126 = gt_normal_3;
        }
        float3  _S1138 = - normalize_0(raydir_15);
        float _S1139 = s_primal_ctx_dot_0(normal_11, _S1138);
        float _S1140 = 1.0f - s_primal_ctx_dot_0(normal_11, _S1126) + 0.00100000004749745f;
        float _S1141 = (F32_max((_S1139), (0.0f))) + 0.00100000004749745f;
        _S1130 = _S1141 * _S1141;
        _S1131 = _S1140;
        _S1132 = _S1141;
        _S1133 = _S1139;
        raydir_15 = normal_11;
        normal_11 = _S1138;
        _runFlag_18 = _S1137;
        _S1125 = _S1136;
        _S1127 = _S1135;
        _S1128 = dx_4;
        _S1129 = _S1134;
    }
    else
    {
        _S1130 = 0.0f;
        _S1131 = 0.0f;
        _S1132 = 0.0f;
        _S1133 = 0.0f;
        raydir_15 = _S1108;
        normal_11 = _S1108;
        _S1126 = _S1108;
        _runFlag_18 = false;
        _S1125 = false;
        _S1127 = _S1108;
        _S1128 = _S1108;
        _S1129 = _S1108;
    }
    float4  _S1142 = make_float4 (0.0f);
    if(_S1124)
    {
        float _S1143 = v_loss_1 / _S1130;
        float _S1144 = _S1131 * - _S1143;
        float s_diff_num_T_1 = _S1132 * _S1143;
        DiffPair_float_0 _S1145;
        (&_S1145)->primal_0 = _S1133;
        (&_S1145)->differential_0 = 0.0f;
        DiffPair_float_0 _S1146;
        (&_S1146)->primal_0 = 0.0f;
        (&_S1146)->differential_0 = 0.0f;
        _d_max_0(&_S1145, &_S1146, _S1144);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1147;
        (&_S1147)->primal_0 = raydir_15;
        (&_S1147)->differential_0 = _S1108;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1148;
        (&_S1148)->primal_0 = normal_11;
        (&_S1148)->differential_0 = _S1108;
        s_bwd_prop_dot_0(&_S1147, &_S1148, _S1145.differential_0);
        float _S1149 = - s_diff_num_T_1;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1150;
        (&_S1150)->primal_0 = raydir_15;
        (&_S1150)->differential_0 = _S1108;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1151;
        (&_S1151)->primal_0 = _S1126;
        (&_S1151)->differential_0 = _S1108;
        s_bwd_prop_dot_0(&_S1150, &_S1151, _S1149);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1152 = _S1151;
        float3  _S1153 = _S1147.differential_0 + _S1150.differential_0;
        if(_runFlag_18)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1154;
            (&_S1154)->primal_0 = gt_normal_3;
            (&_S1154)->differential_0 = _S1108;
            s_bwd_normalize_impl_0(&_S1154, _S1152.differential_0);
            raydir_15 = _S1154.differential_0;
        }
        else
        {
            raydir_15 = _S1152.differential_0;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1155;
        (&_S1155)->primal_0 = gt_normal_3;
        (&_S1155)->differential_0 = _S1108;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1156;
        (&_S1156)->primal_0 = gt_normal_3;
        (&_S1156)->differential_0 = _S1108;
        s_bwd_prop_dot_0(&_S1155, &_S1156, 0.0f);
        float3  _S1157 = _S1156.differential_0 + _S1155.differential_0 + raydir_15;
        if(_S1125)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1158;
            (&_S1158)->primal_0 = _S1127;
            (&_S1158)->differential_0 = _S1108;
            s_bwd_normalize_impl_0(&_S1158, _S1153);
            raydir_15 = _S1158.differential_0;
        }
        else
        {
            raydir_15 = _S1153;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1159;
        (&_S1159)->primal_0 = _S1127;
        (&_S1159)->differential_0 = _S1108;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1160;
        (&_S1160)->primal_0 = _S1127;
        (&_S1160)->differential_0 = _S1108;
        s_bwd_prop_dot_0(&_S1159, &_S1160, 0.0f);
        float3  _S1161 = _S1160.differential_0 + _S1159.differential_0 + raydir_15;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1162;
        (&_S1162)->primal_0 = _S1128;
        (&_S1162)->differential_0 = _S1108;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1163;
        (&_S1163)->primal_0 = _S1129;
        (&_S1163)->differential_0 = _S1108;
        s_bwd_prop_cross_0(&_S1162, &_S1163, _S1161);
        float3  s_diff_dy_T_4 = - _S1163.differential_0;
        float3  _S1164 = - s_diff_dy_T_4;
        float3  _S1165 = - _S1162.differential_0;
        FixedArray<float3 , 5>  _S1166;
        _S1166[int(0)] = _S1108;
        _S1166[int(1)] = _S1108;
        _S1166[int(2)] = _S1108;
        _S1166[int(3)] = _S1108;
        _S1166[int(4)] = _S1108;
        _S1166[int(2)] = _S1164;
        _S1166[int(3)] = s_diff_dy_T_4;
        _S1166[int(0)] = _S1165;
        _S1166[int(1)] = _S1162.differential_0;
        points_9[int(0)] = _S1166[int(0)];
        points_9[int(1)] = _S1166[int(1)];
        points_9[int(2)] = _S1166[int(2)];
        points_9[int(3)] = _S1166[int(3)];
        points_9[int(4)] = _S1166[int(4)];
        raydir_15 = _S1157;
    }
    else
    {
        points_9[int(0)] = _S1108;
        points_9[int(1)] = _S1108;
        points_9[int(2)] = _S1108;
        points_9[int(3)] = _S1108;
        points_9[int(4)] = _S1108;
        raydir_15 = _S1108;
    }
    float4  _S1167;
    if(_S1109)
    {
        if(_runFlag_15)
        {
            if(_runFlag_16)
            {
                if(_runFlag_17)
                {
                    FixedArray<float3 , 5>  _S1168 = points_9;
                    FixedArray<float3 , 5>  _S1169 = points_9;
                    FixedArray<float3 , 5>  _S1170 = points_9;
                    float3  _S1171 = _S1111 * points_9[int(3)];
                    float _S1172 = _S1171.x + _S1171.y + _S1171.z;
                    float4  _S1173 = _S1142;
                    *&((&_S1173)->w) = _S1172;
                    points_9[int(0)] = _S1108;
                    points_9[int(1)] = _S1108;
                    points_9[int(2)] = _S1108;
                    points_9[int(3)] = _S1108;
                    points_9[int(4)] = _S1108;
                    _S1111 = _S1170[int(2)];
                    normal_11 = _S1168[int(0)];
                    _S1126 = _S1169[int(1)];
                    _S1167 = _S1173;
                }
                else
                {
                    FixedArray<float3 , 5>  _S1174 = points_9;
                    FixedArray<float3 , 5>  _S1175 = points_9;
                    FixedArray<float3 , 5>  _S1176 = points_9;
                    FixedArray<float3 , 5>  _S1177 = points_9;
                    points_9[int(0)] = points_9[int(0)];
                    points_9[int(1)] = _S1174[int(1)];
                    points_9[int(2)] = _S1175[int(2)];
                    points_9[int(3)] = _S1176[int(3)];
                    points_9[int(4)] = _S1177[int(4)];
                    _S1111 = _S1108;
                    normal_11 = _S1108;
                    _S1126 = _S1108;
                    _S1167 = _S1142;
                }
                float3  _S1178 = _S1112 * (points_9[int(2)] + _S1111);
                float _S1179 = _S1178.x + _S1178.y + _S1178.z;
                float3  _S1180 = points_9[int(0)] + normal_11;
                float3  _S1181 = points_9[int(1)] + _S1126;
                float4  _S1182 = _S1142;
                *&((&_S1182)->z) = _S1179;
                float4  _S1183 = _S1167 + _S1182;
                points_9[int(0)] = _S1108;
                points_9[int(1)] = _S1108;
                points_9[int(2)] = _S1108;
                points_9[int(3)] = _S1108;
                points_9[int(4)] = _S1108;
                _S1111 = _S1181;
                _S1112 = _S1180;
                _S1167 = _S1183;
            }
            else
            {
                FixedArray<float3 , 5>  _S1184 = points_9;
                FixedArray<float3 , 5>  _S1185 = points_9;
                FixedArray<float3 , 5>  _S1186 = points_9;
                FixedArray<float3 , 5>  _S1187 = points_9;
                points_9[int(0)] = points_9[int(0)];
                points_9[int(1)] = _S1184[int(1)];
                points_9[int(2)] = _S1185[int(2)];
                points_9[int(3)] = _S1186[int(3)];
                points_9[int(4)] = _S1187[int(4)];
                _S1111 = _S1108;
                _S1112 = _S1108;
                _S1167 = _S1142;
            }
            float3  _S1188 = _S1113 * (points_9[int(1)] + _S1111);
            float _S1189 = _S1188.x + _S1188.y + _S1188.z;
            float3  _S1190 = points_9[int(0)] + _S1112;
            float4  _S1191 = _S1142;
            *&((&_S1191)->y) = _S1189;
            float4  _S1192 = _S1167 + _S1191;
            points_9[int(0)] = _S1108;
            points_9[int(1)] = _S1108;
            points_9[int(2)] = _S1108;
            points_9[int(3)] = _S1108;
            points_9[int(4)] = _S1108;
            _S1111 = _S1190;
            _S1167 = _S1192;
        }
        else
        {
            FixedArray<float3 , 5>  _S1193 = points_9;
            FixedArray<float3 , 5>  _S1194 = points_9;
            FixedArray<float3 , 5>  _S1195 = points_9;
            FixedArray<float3 , 5>  _S1196 = points_9;
            points_9[int(0)] = points_9[int(0)];
            points_9[int(1)] = _S1193[int(1)];
            points_9[int(2)] = _S1194[int(2)];
            points_9[int(3)] = _S1195[int(3)];
            points_9[int(4)] = _S1196[int(4)];
            _S1111 = _S1108;
            _S1167 = _S1142;
        }
        float3  _S1197 = _S1114 * (points_9[int(0)] + _S1111);
        float _S1198 = _S1197.x + _S1197.y + _S1197.z;
        float4  _S1199 = _S1142;
        *&((&_S1199)->x) = _S1198;
        _S1167 = _S1167 + _S1199;
    }
    else
    {
        _S1167 = _S1142;
    }
    *v_depths_3 = _S1167;
    *v_gt_normal_1 = raydir_15;
    return;
}

inline __device__ float3  generate_ray_d2n_prism(float2  pix_pos_6, float4  intrins_16, FixedArray<float, 8>  dist_coeffs_20, int camera_model_18, bool is_ray_depth_16)
{
    float3  _S1200;
    for(;;)
    {
        float2  uv_52 = (pix_pos_6 - float2 {intrins_16.z, intrins_16.w}) / float2 {intrins_16.x, intrins_16.y};
        FixedArray<float, 8>  _S1201 = dist_coeffs_20;
        float2  uv_u_24;
        bool _S1202 = undistort_point_2(uv_52, &_S1201, int(12), &uv_u_24);
        if(!_S1202)
        {
            int3  _S1203 = make_int3 (int(0));
            float3  _S1204 = make_float3 ((float)_S1203.x, (float)_S1203.y, (float)_S1203.z);
            _S1200 = _S1204;
            break;
        }
        _S1200 = unproject_raydir_0(uv_u_24, camera_model_18, is_ray_depth_16);
        break;
    }
    return _S1200;
}

inline __device__ float3  depth_to_point_prism(float2  pix_pos_7, float4  intrins_17, FixedArray<float, 8>  dist_coeffs_21, int camera_model_19, bool is_ray_depth_17, float depth_6)
{
    float3  _S1205;
    for(;;)
    {
        float2  uv_53 = (pix_pos_7 - float2 {intrins_17.z, intrins_17.w}) / float2 {intrins_17.x, intrins_17.y};
        FixedArray<float, 8>  _S1206 = dist_coeffs_21;
        float2  uv_u_25;
        bool _S1207 = undistort_point_2(uv_53, &_S1206, int(12), &uv_u_25);
        if(!_S1207)
        {
            _S1205 = make_float3 (0.0f);
            break;
        }
        _S1205 = make_float3 (depth_6) * unproject_raydir_0(uv_u_25, camera_model_19, is_ray_depth_17);
        break;
    }
    return _S1205;
}

struct s_bwd_prop_depth_to_point_Intermediates_2
{
    float2  _S1208;
    bool _S1209;
};

inline __device__ float depth_to_point_vjp_prism(float2  pix_pos_8, float4  intrins_18, FixedArray<float, 8>  dist_coeffs_22, int camera_model_20, bool is_ray_depth_18, float depth_7, float3  v_point_2)
{
    float2  _S1210 = make_float2 (0.0f);
    s_bwd_prop_depth_to_point_Intermediates_2 _S1211;
    (&_S1211)->_S1208 = _S1210;
    (&_S1211)->_S1209 = false;
    float2  uv_54 = (pix_pos_8 - float2 {intrins_18.z, intrins_18.w}) / float2 {intrins_18.x, intrins_18.y};
    float2  _S1212 = _S1210;
    FixedArray<float, 8>  _S1213 = dist_coeffs_22;
    bool _S1214 = undistort_point_2(uv_54, &_S1213, int(12), &_S1212);
    (&_S1211)->_S1208 = _S1212;
    (&_S1211)->_S1209 = _S1214;
    s_bwd_prop_depth_to_point_Intermediates_2 _S1215 = _S1211;
    float3  _S1216 = make_float3 (0.0f);
    bool _S1217 = !!_S1211._S1209;
    float3  _S1218;
    if(_S1217)
    {
        _S1218 = s_primal_ctx_unproject_raydir_0(_S1215._S1208, camera_model_20, is_ray_depth_18);
    }
    else
    {
        _S1218 = _S1216;
    }
    if(_S1217)
    {
        _S1218 = _S1218 * v_point_2;
    }
    else
    {
        _S1218 = _S1216;
    }
    return _S1218.x + _S1218.y + _S1218.z;
}

inline __device__ float3  depth_to_normal_prism(float2  pix_center_10, float4  intrins_19, FixedArray<float, 8>  dist_coeffs_23, int camera_model_21, bool is_ray_depth_19, float4  depths_8)
{
    float3  normal_12;
    for(;;)
    {
        bool _S1219;
        if((depths_8.x) == 0.0f)
        {
            _S1219 = true;
        }
        else
        {
            _S1219 = (depths_8.y) == 0.0f;
        }
        if(_S1219)
        {
            _S1219 = true;
        }
        else
        {
            _S1219 = (depths_8.z) == 0.0f;
        }
        if(_S1219)
        {
            _S1219 = true;
        }
        else
        {
            _S1219 = (depths_8.w) == 0.0f;
        }
        if(_S1219)
        {
            normal_12 = make_float3 (0.0f);
            break;
        }
        float3  * _S1220;
        float3  * _S1221;
        float3  * _S1222;
        float3  * _S1223;
        int _S1224;
        FixedArray<float3 , 4>  points_10;
        for(;;)
        {
            float2  _S1225 = float2 {intrins_19.z, intrins_19.w};
            float2  _S1226 = float2 {intrins_19.x, intrins_19.y};
            float2  uv_55 = (pix_center_10 + make_float2 (-1.0f, -0.0f) - _S1225) / _S1226;
            FixedArray<float, 8>  _S1227 = dist_coeffs_23;
            float2  uv_u_26;
            bool _S1228 = undistort_point_2(uv_55, &_S1227, int(12), &uv_u_26);
            if(!_S1228)
            {
                float3  _S1229 = make_float3 (0.0f);
                _S1224 = int(0);
                _S1223 = nullptr;
                _S1222 = nullptr;
                _S1221 = nullptr;
                _S1220 = nullptr;
                normal_12 = _S1229;
                break;
            }
            points_10[int(0)] = make_float3 (depths_8.x) * unproject_raydir_0(uv_u_26, camera_model_21, is_ray_depth_19);
            for(;;)
            {
                float2  uv_56 = (pix_center_10 + make_float2 (1.0f, -0.0f) - _S1225) / _S1226;
                FixedArray<float, 8>  _S1230 = dist_coeffs_23;
                float2  uv_u_27;
                bool _S1231 = undistort_point_2(uv_56, &_S1230, int(12), &uv_u_27);
                if(!_S1231)
                {
                    float3  _S1232 = make_float3 (0.0f);
                    _S1224 = int(0);
                    _S1223 = nullptr;
                    normal_12 = _S1232;
                    break;
                }
                points_10[int(1)] = make_float3 (depths_8.y) * unproject_raydir_0(uv_u_27, camera_model_21, is_ray_depth_19);
                _S1224 = int(2);
                _S1223 = &points_10[int(1)];
                break;
            }
            if(_S1224 != int(2))
            {
                _S1222 = &points_10[int(0)];
                _S1221 = nullptr;
                _S1220 = nullptr;
                break;
            }
            float2  uv_57 = (pix_center_10 + make_float2 (0.0f, -1.0f) - _S1225) / _S1226;
            FixedArray<float, 8>  _S1233 = dist_coeffs_23;
            float2  uv_u_28;
            bool _S1234 = undistort_point_2(uv_57, &_S1233, int(12), &uv_u_28);
            if(!_S1234)
            {
                float3  _S1235 = make_float3 (0.0f);
                _S1224 = int(0);
                _S1222 = &points_10[int(0)];
                _S1221 = nullptr;
                _S1220 = nullptr;
                normal_12 = _S1235;
                break;
            }
            points_10[int(2)] = make_float3 (depths_8.z) * unproject_raydir_0(uv_u_28, camera_model_21, is_ray_depth_19);
            for(;;)
            {
                float2  uv_58 = (pix_center_10 + make_float2 (0.0f, 1.0f) - _S1225) / _S1226;
                FixedArray<float, 8>  _S1236 = dist_coeffs_23;
                float2  uv_u_29;
                bool _S1237 = undistort_point_2(uv_58, &_S1236, int(12), &uv_u_29);
                if(!_S1237)
                {
                    float3  _S1238 = make_float3 (0.0f);
                    _S1224 = int(0);
                    _S1222 = nullptr;
                    normal_12 = _S1238;
                    break;
                }
                points_10[int(3)] = make_float3 (depths_8.w) * unproject_raydir_0(uv_u_29, camera_model_21, is_ray_depth_19);
                _S1224 = int(2);
                _S1222 = &points_10[int(3)];
                break;
            }
            if(_S1224 != int(2))
            {
                float3  * _S1239 = _S1222;
                _S1222 = &points_10[int(0)];
                _S1221 = _S1239;
                _S1220 = &points_10[int(2)];
                break;
            }
            float3  * _S1240 = _S1222;
            _S1224 = int(1);
            _S1222 = &points_10[int(0)];
            _S1221 = _S1240;
            _S1220 = &points_10[int(2)];
            break;
        }
        if(_S1224 != int(1))
        {
            break;
        }
        float3  normal_13 = cross_0(*_S1223 - *_S1222, - (*_S1221 - *_S1220));
        if((dot_0(normal_13, normal_13)) != 0.0f)
        {
            normal_12 = normal_13 / make_float3 (length_0(normal_13));
        }
        else
        {
            normal_12 = normal_13;
        }
        break;
    }
    return normal_12;
}

struct s_bwd_prop_depth_to_normal_Intermediates_2
{
    float2  _S1241;
    bool _S1242;
    float2  _S1243;
    bool _S1244;
    float2  _S1245;
    bool _S1246;
    float2  _S1247;
    bool _S1248;
};

inline __device__ void depth_to_normal_vjp_prism(float2  pix_center_11, float4  intrins_20, FixedArray<float, 8>  dist_coeffs_24, int camera_model_22, bool is_ray_depth_20, float4  depths_9, float3  v_normal_3, float4  * v_depths_4)
{
    float2  _S1249 = make_float2 (0.0f);
    s_bwd_prop_depth_to_normal_Intermediates_2 _S1250;
    (&_S1250)->_S1241 = _S1249;
    (&_S1250)->_S1242 = false;
    (&_S1250)->_S1243 = _S1249;
    (&_S1250)->_S1244 = false;
    (&_S1250)->_S1245 = _S1249;
    (&_S1250)->_S1246 = false;
    (&_S1250)->_S1247 = _S1249;
    (&_S1250)->_S1248 = false;
    (&_S1250)->_S1241 = _S1249;
    (&_S1250)->_S1242 = false;
    (&_S1250)->_S1243 = _S1249;
    (&_S1250)->_S1244 = false;
    (&_S1250)->_S1245 = _S1249;
    (&_S1250)->_S1246 = false;
    (&_S1250)->_S1247 = _S1249;
    (&_S1250)->_S1248 = false;
    bool _S1251 = (depths_9.x) == 0.0f;
    bool _runFlag_19;
    if(_S1251)
    {
        _runFlag_19 = true;
    }
    else
    {
        _runFlag_19 = (depths_9.y) == 0.0f;
    }
    if(_runFlag_19)
    {
        _runFlag_19 = true;
    }
    else
    {
        _runFlag_19 = (depths_9.z) == 0.0f;
    }
    if(_runFlag_19)
    {
        _runFlag_19 = true;
    }
    else
    {
        _runFlag_19 = (depths_9.w) == 0.0f;
    }
    int _S1252;
    if(!_runFlag_19)
    {
        float2  _S1253 = float2 {intrins_20.z, intrins_20.w};
        float2  _S1254 = float2 {intrins_20.x, intrins_20.y};
        float2  uv_59 = (pix_center_11 + make_float2 (-1.0f, -0.0f) - _S1253) / _S1254;
        float2  _S1255 = _S1249;
        FixedArray<float, 8>  _S1256 = dist_coeffs_24;
        bool _S1257 = undistort_point_2(uv_59, &_S1256, int(12), &_S1255);
        (&_S1250)->_S1241 = _S1255;
        (&_S1250)->_S1242 = _S1257;
        bool _S1258 = !!_S1257;
        if(_S1258)
        {
            float2  uv_60 = (pix_center_11 + make_float2 (1.0f, -0.0f) - _S1253) / _S1254;
            float2  _S1259 = _S1249;
            FixedArray<float, 8>  _S1260 = dist_coeffs_24;
            bool _S1261 = undistort_point_2(uv_60, &_S1260, int(12), &_S1259);
            (&_S1250)->_S1243 = _S1259;
            (&_S1250)->_S1244 = _S1261;
            if(!!_S1261)
            {
                _S1252 = int(2);
            }
            else
            {
                _S1252 = int(0);
            }
            if(_S1252 != int(2))
            {
                _runFlag_19 = false;
            }
            else
            {
                _runFlag_19 = _S1258;
            }
            if(_runFlag_19)
            {
                float2  uv_61 = (pix_center_11 + make_float2 (0.0f, -1.0f) - _S1253) / _S1254;
                float2  _S1262 = _S1249;
                FixedArray<float, 8>  _S1263 = dist_coeffs_24;
                bool _S1264 = undistort_point_2(uv_61, &_S1263, int(12), &_S1262);
                (&_S1250)->_S1245 = _S1262;
                (&_S1250)->_S1246 = _S1264;
                if(!_S1264)
                {
                    _runFlag_19 = false;
                }
                if(_runFlag_19)
                {
                    float2  uv_62 = (pix_center_11 + make_float2 (0.0f, 1.0f) - _S1253) / _S1254;
                    float2  _S1265 = _S1249;
                    FixedArray<float, 8>  _S1266 = dist_coeffs_24;
                    bool _S1267 = undistort_point_2(uv_62, &_S1266, int(12), &_S1265);
                    (&_S1250)->_S1247 = _S1265;
                    (&_S1250)->_S1248 = _S1267;
                }
            }
        }
    }
    s_bwd_prop_depth_to_normal_Intermediates_2 _S1268 = _S1250;
    float3  _S1269 = make_float3 (0.0f);
    if(_S1251)
    {
        _runFlag_19 = true;
    }
    else
    {
        _runFlag_19 = (depths_9.y) == 0.0f;
    }
    if(_runFlag_19)
    {
        _runFlag_19 = true;
    }
    else
    {
        _runFlag_19 = (depths_9.z) == 0.0f;
    }
    if(_runFlag_19)
    {
        _runFlag_19 = true;
    }
    else
    {
        _runFlag_19 = (depths_9.w) == 0.0f;
    }
    bool _S1270 = !_runFlag_19;
    bool _runFlag_20;
    bool _runFlag_21;
    bool _S1271;
    bool _runFlag_22;
    bool _S1272;
    bool _S1273;
    FixedArray<float3 , 4>  points_11;
    float3  _S1274;
    float3  _S1275;
    float3  _S1276;
    float3  _S1277;
    float3  _S1278;
    float3  _S1279;
    float3  _S1280;
    float3  _S1281;
    float3  _S1282;
    if(_S1270)
    {
        bool _S1283 = !!_S1268._S1242;
        if(_S1283)
        {
            float3  _S1284 = s_primal_ctx_unproject_raydir_0(_S1268._S1241, camera_model_22, is_ray_depth_20);
            float3  _S1285 = make_float3 (depths_9.x) * _S1284;
            bool _S1286 = !!_S1268._S1244;
            if(_S1286)
            {
                float3  _S1287 = s_primal_ctx_unproject_raydir_0(_S1268._S1243, camera_model_22, is_ray_depth_20);
                float3  _S1288 = make_float3 (depths_9.y) * _S1287;
                _S1252 = int(2);
                points_11[int(0)] = _S1285;
                points_11[int(1)] = _S1288;
                points_11[int(2)] = _S1269;
                points_11[int(3)] = _S1269;
                _S1274 = _S1287;
            }
            else
            {
                _S1252 = int(0);
                points_11[int(0)] = _S1285;
                points_11[int(1)] = _S1269;
                points_11[int(2)] = _S1269;
                points_11[int(3)] = _S1269;
                _S1274 = _S1269;
            }
            if(_S1252 != int(2))
            {
                _runFlag_19 = false;
            }
            else
            {
                _runFlag_19 = _S1283;
                _S1252 = int(0);
            }
            if(_runFlag_19)
            {
                if(!_S1268._S1246)
                {
                    _runFlag_20 = false;
                    _S1252 = int(0);
                }
                else
                {
                    _runFlag_20 = _runFlag_19;
                }
                if(_runFlag_20)
                {
                    float3  _S1289 = s_primal_ctx_unproject_raydir_0(_S1268._S1245, camera_model_22, is_ray_depth_20);
                    points_11[int(2)] = make_float3 (depths_9.z) * _S1289;
                    bool _S1290 = !!_S1268._S1248;
                    int _S1291;
                    if(_S1290)
                    {
                        float3  _S1292 = s_primal_ctx_unproject_raydir_0(_S1268._S1247, camera_model_22, is_ray_depth_20);
                        points_11[int(3)] = make_float3 (depths_9.w) * _S1292;
                        _S1291 = int(2);
                        _S1275 = _S1292;
                    }
                    else
                    {
                        _S1291 = int(0);
                        _S1275 = _S1269;
                    }
                    if(_S1291 != int(2))
                    {
                        _runFlag_21 = false;
                        _S1252 = _S1291;
                    }
                    else
                    {
                        _runFlag_21 = _runFlag_20;
                    }
                    if(_runFlag_21)
                    {
                        _S1252 = int(1);
                    }
                    _runFlag_21 = _S1290;
                    _S1276 = _S1289;
                }
                else
                {
                    _runFlag_21 = false;
                    _S1275 = _S1269;
                    _S1276 = _S1269;
                }
            }
            else
            {
                _runFlag_20 = false;
                _runFlag_21 = false;
                _S1275 = _S1269;
                _S1276 = _S1269;
            }
            float3  _S1293 = _S1274;
            _S1274 = _S1275;
            _S1275 = _S1276;
            _S1271 = _S1286;
            _S1276 = _S1293;
            _S1277 = _S1284;
        }
        else
        {
            _S1252 = int(0);
            points_11[int(0)] = _S1269;
            points_11[int(1)] = _S1269;
            points_11[int(2)] = _S1269;
            points_11[int(3)] = _S1269;
            _runFlag_19 = false;
            _runFlag_20 = false;
            _runFlag_21 = false;
            _S1274 = _S1269;
            _S1275 = _S1269;
            _S1271 = false;
            _S1276 = _S1269;
            _S1277 = _S1269;
        }
        if(_S1252 != int(1))
        {
            _runFlag_22 = false;
        }
        else
        {
            _runFlag_22 = _S1270;
        }
        if(_runFlag_22)
        {
            float3  dx_5 = points_11[int(1)] - points_11[int(0)];
            float3  _S1294 = - (points_11[int(3)] - points_11[int(2)]);
            float3  _S1295 = s_primal_ctx_cross_0(dx_5, _S1294);
            bool _S1296 = (s_primal_ctx_dot_0(_S1295, _S1295)) != 0.0f;
            if(_S1296)
            {
                float _S1297 = length_0(_S1295);
                float3  _S1298 = make_float3 (_S1297);
                _S1278 = make_float3 (_S1297 * _S1297);
                _S1279 = _S1298;
            }
            else
            {
                _S1278 = _S1269;
                _S1279 = _S1269;
            }
            float3  _S1299 = _S1279;
            _S1272 = _S1296;
            _S1279 = _S1295;
            _S1280 = _S1299;
            _S1281 = dx_5;
            _S1282 = _S1294;
        }
        else
        {
            _S1272 = false;
            _S1278 = _S1269;
            _S1279 = _S1269;
            _S1280 = _S1269;
            _S1281 = _S1269;
            _S1282 = _S1269;
        }
        bool _S1300 = _runFlag_19;
        bool _S1301 = _runFlag_20;
        bool _S1302 = _runFlag_21;
        float3  _S1303 = _S1274;
        float3  _S1304 = _S1275;
        bool _S1305 = _S1271;
        float3  _S1306 = _S1276;
        float3  _S1307 = _S1277;
        _runFlag_19 = _runFlag_22;
        _runFlag_20 = _S1272;
        _S1274 = _S1278;
        _S1275 = _S1279;
        _S1276 = _S1280;
        _S1277 = _S1281;
        _S1278 = _S1282;
        _runFlag_21 = _S1283;
        _S1271 = _S1300;
        _runFlag_22 = _S1301;
        _S1272 = _S1302;
        _S1279 = _S1303;
        _S1280 = _S1304;
        _S1273 = _S1305;
        _S1281 = _S1306;
        _S1282 = _S1307;
    }
    else
    {
        _runFlag_19 = false;
        _runFlag_20 = false;
        _S1274 = _S1269;
        _S1275 = _S1269;
        _S1276 = _S1269;
        _S1277 = _S1269;
        _S1278 = _S1269;
        _runFlag_21 = false;
        _S1271 = false;
        _runFlag_22 = false;
        _S1272 = false;
        _S1279 = _S1269;
        _S1280 = _S1269;
        _S1273 = false;
        _S1281 = _S1269;
        _S1282 = _S1269;
    }
    float4  _S1308 = make_float4 (0.0f);
    float4  _S1309;
    if(_S1270)
    {
        if(_runFlag_19)
        {
            if(_runFlag_20)
            {
                float3  _S1310 = v_normal_3 / _S1274;
                float3  _S1311 = _S1275 * - _S1310;
                float3  _S1312 = _S1276 * _S1310;
                float _S1313 = _S1311.x + _S1311.y + _S1311.z;
                DiffPair_vectorx3Cfloatx2C3x3E_0 _S1314;
                (&_S1314)->primal_0 = _S1275;
                (&_S1314)->differential_0 = _S1269;
                s_bwd_length_impl_0(&_S1314, _S1313);
                _S1274 = _S1312 + _S1314.differential_0;
            }
            else
            {
                _S1274 = v_normal_3;
            }
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1315;
            (&_S1315)->primal_0 = _S1275;
            (&_S1315)->differential_0 = _S1269;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1316;
            (&_S1316)->primal_0 = _S1275;
            (&_S1316)->differential_0 = _S1269;
            s_bwd_prop_dot_0(&_S1315, &_S1316, 0.0f);
            float3  _S1317 = _S1316.differential_0 + _S1315.differential_0 + _S1274;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1318;
            (&_S1318)->primal_0 = _S1277;
            (&_S1318)->differential_0 = _S1269;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1319;
            (&_S1319)->primal_0 = _S1278;
            (&_S1319)->differential_0 = _S1269;
            s_bwd_prop_cross_0(&_S1318, &_S1319, _S1317);
            float3  s_diff_dy_T_5 = - _S1319.differential_0;
            float3  _S1320 = - s_diff_dy_T_5;
            float3  _S1321 = - _S1318.differential_0;
            FixedArray<float3 , 4>  _S1322;
            _S1322[int(0)] = _S1269;
            _S1322[int(1)] = _S1269;
            _S1322[int(2)] = _S1269;
            _S1322[int(3)] = _S1269;
            _S1322[int(2)] = _S1320;
            _S1322[int(3)] = s_diff_dy_T_5;
            _S1322[int(0)] = _S1321;
            _S1322[int(1)] = _S1318.differential_0;
            points_11[int(0)] = _S1322[int(0)];
            points_11[int(1)] = _S1322[int(1)];
            points_11[int(2)] = _S1322[int(2)];
            points_11[int(3)] = _S1322[int(3)];
        }
        else
        {
            points_11[int(0)] = _S1269;
            points_11[int(1)] = _S1269;
            points_11[int(2)] = _S1269;
            points_11[int(3)] = _S1269;
        }
        if(_runFlag_21)
        {
            if(_S1271)
            {
                if(_runFlag_22)
                {
                    FixedArray<float3 , 4>  _S1323 = points_11;
                    FixedArray<float3 , 4>  _S1324 = points_11;
                    FixedArray<float3 , 4>  _S1325 = points_11;
                    FixedArray<float3 , 4>  _S1326 = points_11;
                    if(_S1272)
                    {
                        float3  _S1327 = _S1279 * _S1326[int(3)];
                        float _S1328 = _S1327.x + _S1327.y + _S1327.z;
                        float4  _S1329 = _S1308;
                        *&((&_S1329)->w) = _S1328;
                        points_11[int(0)] = _S1323[int(0)];
                        points_11[int(1)] = _S1324[int(1)];
                        points_11[int(2)] = _S1325[int(2)];
                        points_11[int(3)] = _S1269;
                        _S1309 = _S1329;
                    }
                    else
                    {
                        points_11[int(0)] = _S1323[int(0)];
                        points_11[int(1)] = _S1324[int(1)];
                        points_11[int(2)] = _S1325[int(2)];
                        points_11[int(3)] = _S1326[int(3)];
                        _S1309 = _S1308;
                    }
                    float3  _S1330 = _S1280 * points_11[int(2)];
                    float _S1331 = _S1330.x + _S1330.y + _S1330.z;
                    FixedArray<float3 , 4>  _S1332 = points_11;
                    FixedArray<float3 , 4>  _S1333 = points_11;
                    float4  _S1334 = _S1308;
                    *&((&_S1334)->z) = _S1331;
                    float4  _S1335 = _S1309 + _S1334;
                    points_11[int(0)] = points_11[int(0)];
                    points_11[int(1)] = _S1332[int(1)];
                    points_11[int(2)] = _S1269;
                    points_11[int(3)] = _S1333[int(3)];
                    _S1309 = _S1335;
                }
                else
                {
                    FixedArray<float3 , 4>  _S1336 = points_11;
                    FixedArray<float3 , 4>  _S1337 = points_11;
                    FixedArray<float3 , 4>  _S1338 = points_11;
                    points_11[int(0)] = points_11[int(0)];
                    points_11[int(1)] = _S1336[int(1)];
                    points_11[int(2)] = _S1337[int(2)];
                    points_11[int(3)] = _S1338[int(3)];
                    _S1309 = _S1308;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S1339 = points_11;
                FixedArray<float3 , 4>  _S1340 = points_11;
                FixedArray<float3 , 4>  _S1341 = points_11;
                points_11[int(0)] = points_11[int(0)];
                points_11[int(1)] = _S1339[int(1)];
                points_11[int(2)] = _S1340[int(2)];
                points_11[int(3)] = _S1341[int(3)];
                _S1309 = _S1308;
            }
            if(_S1273)
            {
                FixedArray<float3 , 4>  _S1342 = points_11;
                float3  _S1343 = _S1281 * points_11[int(1)];
                float _S1344 = _S1343.x + _S1343.y + _S1343.z;
                float4  _S1345 = _S1308;
                *&((&_S1345)->y) = _S1344;
                float4  _S1346 = _S1309 + _S1345;
                points_11[int(0)] = _S1269;
                points_11[int(1)] = _S1269;
                points_11[int(2)] = _S1269;
                points_11[int(3)] = _S1269;
                _S1274 = _S1342[int(0)];
                _S1309 = _S1346;
            }
            else
            {
                FixedArray<float3 , 4>  _S1347 = points_11;
                FixedArray<float3 , 4>  _S1348 = points_11;
                FixedArray<float3 , 4>  _S1349 = points_11;
                points_11[int(0)] = points_11[int(0)];
                points_11[int(1)] = _S1347[int(1)];
                points_11[int(2)] = _S1348[int(2)];
                points_11[int(3)] = _S1349[int(3)];
                _S1274 = _S1269;
            }
            float3  _S1350 = _S1282 * (points_11[int(0)] + _S1274);
            float _S1351 = _S1350.x + _S1350.y + _S1350.z;
            float4  _S1352 = _S1308;
            *&((&_S1352)->x) = _S1351;
            _S1309 = _S1309 + _S1352;
        }
        else
        {
            _S1309 = _S1308;
        }
    }
    else
    {
        _S1309 = _S1308;
    }
    *v_depths_4 = _S1309;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_prism(float2  pix_center_12, float4  intrins_21, FixedArray<float, 8>  dist_coeffs_25, int camera_model_23)
{
    float _S1353;
    for(;;)
    {
        float2  uv_63 = (pix_center_12 - float2 {intrins_21.z, intrins_21.w}) / float2 {intrins_21.x, intrins_21.y};
        FixedArray<float, 8>  _S1354 = dist_coeffs_25;
        float2  uv_u_30;
        bool _S1355 = undistort_point_2(uv_63, &_S1354, int(12), &uv_u_30);
        if(!_S1355)
        {
            _S1353 = 0.0f;
            break;
        }
        float3  raydir_16 = unproject_raydir_0(uv_u_30, camera_model_23, false);
        _S1353 = float((F32_sign((raydir_16.z)))) / length_0(raydir_16);
        break;
    }
    return _S1353;
}

inline __device__ float depth_normal_loss_prism(float2  pix_center_13, float4  intrins_22, FixedArray<float, 8>  dist_coeffs_26, int camera_model_24, bool is_ray_depth_21, float4  depths_10, float3  gt_normal_4)
{
    float _S1356;
    for(;;)
    {
        float3  _S1357;
        float3  * _S1358;
        float3  * _S1359;
        float3  * _S1360;
        float3  * _S1361;
        int _S1362;
        FixedArray<float3 , 5>  points_12;
        for(;;)
        {
            float2  _S1363 = float2 {intrins_22.z, intrins_22.w};
            float2  _S1364 = float2 {intrins_22.x, intrins_22.y};
            float2  uv_64 = (pix_center_13 + make_float2 (-1.0f, -0.0f) - _S1363) / _S1364;
            FixedArray<float, 8>  _S1365 = dist_coeffs_26;
            float2  uv_u_31;
            bool _S1366 = undistort_point_2(uv_64, &_S1365, int(12), &uv_u_31);
            float3  _S1367 = make_float3 (0.0f);
            if(!_S1366)
            {
                _S1362 = int(0);
                _S1361 = nullptr;
                _S1360 = nullptr;
                _S1359 = nullptr;
                _S1358 = nullptr;
                _S1357 = _S1367;
                break;
            }
            float3  raydir_17 = unproject_raydir_0(uv_u_31, camera_model_24, is_ray_depth_21);
            points_12[int(0)] = make_float3 (depths_10.x) * raydir_17;
            float2  uv_65 = (pix_center_13 + make_float2 (1.0f, -0.0f) - _S1363) / _S1364;
            FixedArray<float, 8>  _S1368 = dist_coeffs_26;
            float2  uv_u_32;
            bool _S1369 = undistort_point_2(uv_65, &_S1368, int(12), &uv_u_32);
            if(!_S1369)
            {
                _S1362 = int(0);
                _S1361 = nullptr;
                _S1360 = &points_12[int(0)];
                _S1359 = nullptr;
                _S1358 = nullptr;
                _S1357 = _S1367;
                break;
            }
            float3  raydir_18 = unproject_raydir_0(uv_u_32, camera_model_24, is_ray_depth_21);
            points_12[int(1)] = make_float3 (depths_10.y) * raydir_18;
            float2  uv_66 = (pix_center_13 + make_float2 (0.0f, -1.0f) - _S1363) / _S1364;
            FixedArray<float, 8>  _S1370 = dist_coeffs_26;
            float2  uv_u_33;
            bool _S1371 = undistort_point_2(uv_66, &_S1370, int(12), &uv_u_33);
            if(!_S1371)
            {
                _S1362 = int(0);
                _S1361 = &points_12[int(1)];
                _S1360 = &points_12[int(0)];
                _S1359 = nullptr;
                _S1358 = nullptr;
                _S1357 = _S1367;
                break;
            }
            float3  raydir_19 = unproject_raydir_0(uv_u_33, camera_model_24, is_ray_depth_21);
            points_12[int(2)] = make_float3 (depths_10.z) * raydir_19;
            float2  uv_67 = (pix_center_13 + make_float2 (0.0f, 1.0f) - _S1363) / _S1364;
            FixedArray<float, 8>  _S1372 = dist_coeffs_26;
            float2  uv_u_34;
            bool _S1373 = undistort_point_2(uv_67, &_S1372, int(12), &uv_u_34);
            if(!_S1373)
            {
                _S1362 = int(0);
                _S1361 = &points_12[int(1)];
                _S1360 = &points_12[int(0)];
                _S1359 = nullptr;
                _S1358 = &points_12[int(2)];
                _S1357 = _S1367;
                break;
            }
            float3  raydir_20 = unproject_raydir_0(uv_u_34, camera_model_24, is_ray_depth_21);
            points_12[int(3)] = make_float3 (depths_10.w) * raydir_20;
            float2  uv_68 = (pix_center_13 + make_float2 (0.0f) * make_float2 (0.0f, 3.0f) - _S1363) / _S1364;
            FixedArray<float, 8>  _S1374 = dist_coeffs_26;
            float2  uv_u_35;
            bool _S1375 = undistort_point_2(uv_68, &_S1374, int(12), &uv_u_35);
            if(!_S1375)
            {
                _S1362 = int(0);
                _S1361 = &points_12[int(1)];
                _S1360 = &points_12[int(0)];
                _S1359 = &points_12[int(3)];
                _S1358 = &points_12[int(2)];
                _S1357 = _S1367;
                break;
            }
            float3  raydir_21 = unproject_raydir_0(uv_u_35, camera_model_24, is_ray_depth_21);
            _S1362 = int(1);
            _S1361 = &points_12[int(1)];
            _S1360 = &points_12[int(0)];
            _S1359 = &points_12[int(3)];
            _S1358 = &points_12[int(2)];
            _S1357 = raydir_21;
            break;
        }
        if(_S1362 != int(1))
        {
            _S1356 = 0.0f;
            break;
        }
        float3  normal_14 = cross_0(*_S1361 - *_S1360, - (*_S1359 - *_S1358));
        float3  normal_15;
        if((dot_0(normal_14, normal_14)) != 0.0f)
        {
            normal_15 = normalize_0(normal_14);
        }
        else
        {
            normal_15 = normal_14;
        }
        float3  _S1376;
        if((dot_0(gt_normal_4, gt_normal_4)) != 0.0f)
        {
            _S1376 = normalize_0(gt_normal_4);
        }
        else
        {
            _S1376 = gt_normal_4;
        }
        _S1356 = (1.0f - dot_0(normal_15, _S1376) + 0.00100000004749745f) / ((F32_max((dot_0(normal_15, - normalize_0(_S1357))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S1356;
}

struct s_bwd_prop_depth_normal_loss_Intermediates_2
{
    float2  _S1377;
    bool _S1378;
    float2  _S1379;
    bool _S1380;
    float2  _S1381;
    bool _S1382;
    float2  _S1383;
    bool _S1384;
    float2  _S1385;
    bool _S1386;
};

inline __device__ void depth_normal_loss_vjp_prism(float2  pix_center_14, float4  intrins_23, FixedArray<float, 8>  dist_coeffs_27, int camera_model_25, bool is_ray_depth_22, float4  depths_11, float3  gt_normal_5, float v_loss_2, float4  * v_depths_5, float3  * v_gt_normal_2)
{
    float2  _S1387 = make_float2 (0.0f);
    s_bwd_prop_depth_normal_loss_Intermediates_2 _S1388;
    (&_S1388)->_S1377 = _S1387;
    (&_S1388)->_S1378 = false;
    (&_S1388)->_S1379 = _S1387;
    (&_S1388)->_S1380 = false;
    (&_S1388)->_S1381 = _S1387;
    (&_S1388)->_S1382 = false;
    (&_S1388)->_S1383 = _S1387;
    (&_S1388)->_S1384 = false;
    (&_S1388)->_S1385 = _S1387;
    (&_S1388)->_S1386 = false;
    (&_S1388)->_S1379 = _S1387;
    (&_S1388)->_S1380 = false;
    (&_S1388)->_S1381 = _S1387;
    (&_S1388)->_S1382 = false;
    (&_S1388)->_S1383 = _S1387;
    (&_S1388)->_S1384 = false;
    (&_S1388)->_S1385 = _S1387;
    (&_S1388)->_S1386 = false;
    float2  _S1389 = float2 {intrins_23.z, intrins_23.w};
    float2  _S1390 = float2 {intrins_23.x, intrins_23.y};
    float2  uv_69 = (pix_center_14 + make_float2 (-1.0f, -0.0f) - _S1389) / _S1390;
    float2  _S1391 = _S1387;
    FixedArray<float, 8>  _S1392 = dist_coeffs_27;
    bool _S1393 = undistort_point_2(uv_69, &_S1392, int(12), &_S1391);
    (&_S1388)->_S1377 = _S1391;
    (&_S1388)->_S1378 = _S1393;
    bool _S1394 = !!_S1393;
    bool _runFlag_23;
    if(_S1394)
    {
        float2  uv_70 = (pix_center_14 + make_float2 (1.0f, -0.0f) - _S1389) / _S1390;
        float2  _S1395 = _S1387;
        FixedArray<float, 8>  _S1396 = dist_coeffs_27;
        bool _S1397 = undistort_point_2(uv_70, &_S1396, int(12), &_S1395);
        (&_S1388)->_S1379 = _S1395;
        (&_S1388)->_S1380 = _S1397;
        if(!_S1397)
        {
            _runFlag_23 = false;
        }
        else
        {
            _runFlag_23 = _S1394;
        }
        if(_runFlag_23)
        {
            float2  uv_71 = (pix_center_14 + make_float2 (0.0f, -1.0f) - _S1389) / _S1390;
            float2  _S1398 = _S1387;
            FixedArray<float, 8>  _S1399 = dist_coeffs_27;
            bool _S1400 = undistort_point_2(uv_71, &_S1399, int(12), &_S1398);
            (&_S1388)->_S1381 = _S1398;
            (&_S1388)->_S1382 = _S1400;
            if(!_S1400)
            {
                _runFlag_23 = false;
            }
            if(_runFlag_23)
            {
                float2  uv_72 = (pix_center_14 + make_float2 (0.0f, 1.0f) - _S1389) / _S1390;
                float2  _S1401 = _S1387;
                FixedArray<float, 8>  _S1402 = dist_coeffs_27;
                bool _S1403 = undistort_point_2(uv_72, &_S1402, int(12), &_S1401);
                (&_S1388)->_S1383 = _S1401;
                (&_S1388)->_S1384 = _S1403;
                if(!_S1403)
                {
                    _runFlag_23 = false;
                }
                if(_runFlag_23)
                {
                    float2  uv_73 = (pix_center_14 - _S1389) / _S1390;
                    float2  _S1404 = _S1387;
                    FixedArray<float, 8>  _S1405 = dist_coeffs_27;
                    bool _S1406 = undistort_point_2(uv_73, &_S1405, int(12), &_S1404);
                    (&_S1388)->_S1385 = _S1404;
                    (&_S1388)->_S1386 = _S1406;
                }
            }
        }
    }
    s_bwd_prop_depth_normal_loss_Intermediates_2 _S1407 = _S1388;
    float3  _S1408 = make_float3 (0.0f);
    bool _S1409 = !!_S1388._S1378;
    bool _runFlag_24;
    bool _runFlag_25;
    bool _runFlag_26;
    int _S1410;
    float3  raydir_22;
    float3  _S1411;
    float3  _S1412;
    float3  _S1413;
    float3  _S1414;
    FixedArray<float3 , 5>  points_13;
    if(_S1409)
    {
        float3  _S1415 = s_primal_ctx_unproject_raydir_0(_S1407._S1377, camera_model_25, is_ray_depth_22);
        float3  _S1416 = make_float3 (depths_11.x) * _S1415;
        if(!_S1407._S1380)
        {
            _runFlag_23 = false;
        }
        else
        {
            _runFlag_23 = _S1409;
        }
        if(_runFlag_23)
        {
            float3  _S1417 = s_primal_ctx_unproject_raydir_0(_S1407._S1379, camera_model_25, is_ray_depth_22);
            float3  _S1418 = make_float3 (depths_11.y) * _S1417;
            if(!_S1407._S1382)
            {
                _runFlag_24 = false;
            }
            else
            {
                _runFlag_24 = _runFlag_23;
            }
            if(_runFlag_24)
            {
                float3  _S1419 = s_primal_ctx_unproject_raydir_0(_S1407._S1381, camera_model_25, is_ray_depth_22);
                float3  _S1420 = make_float3 (depths_11.z) * _S1419;
                if(!_S1407._S1384)
                {
                    _runFlag_25 = false;
                }
                else
                {
                    _runFlag_25 = _runFlag_24;
                }
                if(_runFlag_25)
                {
                    float3  _S1421 = s_primal_ctx_unproject_raydir_0(_S1407._S1383, camera_model_25, is_ray_depth_22);
                    float3  _S1422 = make_float3 (depths_11.w) * _S1421;
                    if(!_S1407._S1386)
                    {
                        _runFlag_26 = false;
                    }
                    else
                    {
                        _runFlag_26 = _runFlag_25;
                    }
                    if(_runFlag_26)
                    {
                        float3  _S1423 = s_primal_ctx_unproject_raydir_0(_S1407._S1385, camera_model_25, is_ray_depth_22);
                        _S1410 = int(1);
                        raydir_22 = _S1423;
                    }
                    else
                    {
                        _S1410 = int(0);
                        raydir_22 = _S1421;
                    }
                    points_13[int(0)] = _S1416;
                    points_13[int(1)] = _S1418;
                    points_13[int(2)] = _S1420;
                    points_13[int(3)] = _S1422;
                    points_13[int(4)] = _S1408;
                    _S1411 = _S1421;
                }
                else
                {
                    _S1410 = int(0);
                    raydir_22 = _S1419;
                    points_13[int(0)] = _S1416;
                    points_13[int(1)] = _S1418;
                    points_13[int(2)] = _S1420;
                    points_13[int(3)] = _S1408;
                    points_13[int(4)] = _S1408;
                    _S1411 = _S1408;
                }
                _S1412 = _S1419;
            }
            else
            {
                _S1410 = int(0);
                raydir_22 = _S1417;
                points_13[int(0)] = _S1416;
                points_13[int(1)] = _S1418;
                points_13[int(2)] = _S1408;
                points_13[int(3)] = _S1408;
                points_13[int(4)] = _S1408;
                _runFlag_25 = false;
                _S1411 = _S1408;
                _S1412 = _S1408;
            }
            _S1413 = _S1417;
        }
        else
        {
            _S1410 = int(0);
            raydir_22 = _S1415;
            points_13[int(0)] = _S1416;
            points_13[int(1)] = _S1408;
            points_13[int(2)] = _S1408;
            points_13[int(3)] = _S1408;
            points_13[int(4)] = _S1408;
            _runFlag_24 = false;
            _runFlag_25 = false;
            _S1411 = _S1408;
            _S1412 = _S1408;
            _S1413 = _S1408;
        }
        _S1414 = _S1415;
    }
    else
    {
        _S1410 = int(0);
        points_13[int(0)] = _S1408;
        points_13[int(1)] = _S1408;
        points_13[int(2)] = _S1408;
        points_13[int(3)] = _S1408;
        points_13[int(4)] = _S1408;
        _runFlag_23 = false;
        _runFlag_24 = false;
        _runFlag_25 = false;
        _S1411 = _S1408;
        _S1412 = _S1408;
        _S1413 = _S1408;
        _S1414 = _S1408;
    }
    bool _S1424 = !(_S1410 != int(1));
    bool _S1425;
    float3  normal_16;
    float3  _S1426;
    float3  _S1427;
    float3  _S1428;
    float3  _S1429;
    float _S1430;
    float _S1431;
    float _S1432;
    float _S1433;
    if(_S1424)
    {
        float3  dx_6 = points_13[int(1)] - points_13[int(0)];
        float3  _S1434 = - (points_13[int(3)] - points_13[int(2)]);
        float3  _S1435 = s_primal_ctx_cross_0(dx_6, _S1434);
        bool _S1436 = (s_primal_ctx_dot_0(_S1435, _S1435)) != 0.0f;
        if(_S1436)
        {
            normal_16 = normalize_0(_S1435);
        }
        else
        {
            normal_16 = _S1435;
        }
        bool _S1437 = (s_primal_ctx_dot_0(gt_normal_5, gt_normal_5)) != 0.0f;
        if(_S1437)
        {
            _S1426 = normalize_0(gt_normal_5);
        }
        else
        {
            _S1426 = gt_normal_5;
        }
        float3  _S1438 = - normalize_0(raydir_22);
        float _S1439 = s_primal_ctx_dot_0(normal_16, _S1438);
        float _S1440 = 1.0f - s_primal_ctx_dot_0(normal_16, _S1426) + 0.00100000004749745f;
        float _S1441 = (F32_max((_S1439), (0.0f))) + 0.00100000004749745f;
        _S1430 = _S1441 * _S1441;
        _S1431 = _S1440;
        _S1432 = _S1441;
        _S1433 = _S1439;
        raydir_22 = normal_16;
        normal_16 = _S1438;
        _runFlag_26 = _S1437;
        _S1425 = _S1436;
        _S1427 = _S1435;
        _S1428 = dx_6;
        _S1429 = _S1434;
    }
    else
    {
        _S1430 = 0.0f;
        _S1431 = 0.0f;
        _S1432 = 0.0f;
        _S1433 = 0.0f;
        raydir_22 = _S1408;
        normal_16 = _S1408;
        _S1426 = _S1408;
        _runFlag_26 = false;
        _S1425 = false;
        _S1427 = _S1408;
        _S1428 = _S1408;
        _S1429 = _S1408;
    }
    float4  _S1442 = make_float4 (0.0f);
    if(_S1424)
    {
        float _S1443 = v_loss_2 / _S1430;
        float _S1444 = _S1431 * - _S1443;
        float s_diff_num_T_2 = _S1432 * _S1443;
        DiffPair_float_0 _S1445;
        (&_S1445)->primal_0 = _S1433;
        (&_S1445)->differential_0 = 0.0f;
        DiffPair_float_0 _S1446;
        (&_S1446)->primal_0 = 0.0f;
        (&_S1446)->differential_0 = 0.0f;
        _d_max_0(&_S1445, &_S1446, _S1444);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1447;
        (&_S1447)->primal_0 = raydir_22;
        (&_S1447)->differential_0 = _S1408;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1448;
        (&_S1448)->primal_0 = normal_16;
        (&_S1448)->differential_0 = _S1408;
        s_bwd_prop_dot_0(&_S1447, &_S1448, _S1445.differential_0);
        float _S1449 = - s_diff_num_T_2;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1450;
        (&_S1450)->primal_0 = raydir_22;
        (&_S1450)->differential_0 = _S1408;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1451;
        (&_S1451)->primal_0 = _S1426;
        (&_S1451)->differential_0 = _S1408;
        s_bwd_prop_dot_0(&_S1450, &_S1451, _S1449);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1452 = _S1451;
        float3  _S1453 = _S1447.differential_0 + _S1450.differential_0;
        if(_runFlag_26)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1454;
            (&_S1454)->primal_0 = gt_normal_5;
            (&_S1454)->differential_0 = _S1408;
            s_bwd_normalize_impl_0(&_S1454, _S1452.differential_0);
            raydir_22 = _S1454.differential_0;
        }
        else
        {
            raydir_22 = _S1452.differential_0;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1455;
        (&_S1455)->primal_0 = gt_normal_5;
        (&_S1455)->differential_0 = _S1408;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1456;
        (&_S1456)->primal_0 = gt_normal_5;
        (&_S1456)->differential_0 = _S1408;
        s_bwd_prop_dot_0(&_S1455, &_S1456, 0.0f);
        float3  _S1457 = _S1456.differential_0 + _S1455.differential_0 + raydir_22;
        if(_S1425)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1458;
            (&_S1458)->primal_0 = _S1427;
            (&_S1458)->differential_0 = _S1408;
            s_bwd_normalize_impl_0(&_S1458, _S1453);
            raydir_22 = _S1458.differential_0;
        }
        else
        {
            raydir_22 = _S1453;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1459;
        (&_S1459)->primal_0 = _S1427;
        (&_S1459)->differential_0 = _S1408;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1460;
        (&_S1460)->primal_0 = _S1427;
        (&_S1460)->differential_0 = _S1408;
        s_bwd_prop_dot_0(&_S1459, &_S1460, 0.0f);
        float3  _S1461 = _S1460.differential_0 + _S1459.differential_0 + raydir_22;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1462;
        (&_S1462)->primal_0 = _S1428;
        (&_S1462)->differential_0 = _S1408;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1463;
        (&_S1463)->primal_0 = _S1429;
        (&_S1463)->differential_0 = _S1408;
        s_bwd_prop_cross_0(&_S1462, &_S1463, _S1461);
        float3  s_diff_dy_T_6 = - _S1463.differential_0;
        float3  _S1464 = - s_diff_dy_T_6;
        float3  _S1465 = - _S1462.differential_0;
        FixedArray<float3 , 5>  _S1466;
        _S1466[int(0)] = _S1408;
        _S1466[int(1)] = _S1408;
        _S1466[int(2)] = _S1408;
        _S1466[int(3)] = _S1408;
        _S1466[int(4)] = _S1408;
        _S1466[int(2)] = _S1464;
        _S1466[int(3)] = s_diff_dy_T_6;
        _S1466[int(0)] = _S1465;
        _S1466[int(1)] = _S1462.differential_0;
        points_13[int(0)] = _S1466[int(0)];
        points_13[int(1)] = _S1466[int(1)];
        points_13[int(2)] = _S1466[int(2)];
        points_13[int(3)] = _S1466[int(3)];
        points_13[int(4)] = _S1466[int(4)];
        raydir_22 = _S1457;
    }
    else
    {
        points_13[int(0)] = _S1408;
        points_13[int(1)] = _S1408;
        points_13[int(2)] = _S1408;
        points_13[int(3)] = _S1408;
        points_13[int(4)] = _S1408;
        raydir_22 = _S1408;
    }
    float4  _S1467;
    if(_S1409)
    {
        if(_runFlag_23)
        {
            if(_runFlag_24)
            {
                if(_runFlag_25)
                {
                    FixedArray<float3 , 5>  _S1468 = points_13;
                    FixedArray<float3 , 5>  _S1469 = points_13;
                    FixedArray<float3 , 5>  _S1470 = points_13;
                    float3  _S1471 = _S1411 * points_13[int(3)];
                    float _S1472 = _S1471.x + _S1471.y + _S1471.z;
                    float4  _S1473 = _S1442;
                    *&((&_S1473)->w) = _S1472;
                    points_13[int(0)] = _S1408;
                    points_13[int(1)] = _S1408;
                    points_13[int(2)] = _S1408;
                    points_13[int(3)] = _S1408;
                    points_13[int(4)] = _S1408;
                    _S1411 = _S1470[int(2)];
                    normal_16 = _S1468[int(0)];
                    _S1426 = _S1469[int(1)];
                    _S1467 = _S1473;
                }
                else
                {
                    FixedArray<float3 , 5>  _S1474 = points_13;
                    FixedArray<float3 , 5>  _S1475 = points_13;
                    FixedArray<float3 , 5>  _S1476 = points_13;
                    FixedArray<float3 , 5>  _S1477 = points_13;
                    points_13[int(0)] = points_13[int(0)];
                    points_13[int(1)] = _S1474[int(1)];
                    points_13[int(2)] = _S1475[int(2)];
                    points_13[int(3)] = _S1476[int(3)];
                    points_13[int(4)] = _S1477[int(4)];
                    _S1411 = _S1408;
                    normal_16 = _S1408;
                    _S1426 = _S1408;
                    _S1467 = _S1442;
                }
                float3  _S1478 = _S1412 * (points_13[int(2)] + _S1411);
                float _S1479 = _S1478.x + _S1478.y + _S1478.z;
                float3  _S1480 = points_13[int(0)] + normal_16;
                float3  _S1481 = points_13[int(1)] + _S1426;
                float4  _S1482 = _S1442;
                *&((&_S1482)->z) = _S1479;
                float4  _S1483 = _S1467 + _S1482;
                points_13[int(0)] = _S1408;
                points_13[int(1)] = _S1408;
                points_13[int(2)] = _S1408;
                points_13[int(3)] = _S1408;
                points_13[int(4)] = _S1408;
                _S1411 = _S1481;
                _S1412 = _S1480;
                _S1467 = _S1483;
            }
            else
            {
                FixedArray<float3 , 5>  _S1484 = points_13;
                FixedArray<float3 , 5>  _S1485 = points_13;
                FixedArray<float3 , 5>  _S1486 = points_13;
                FixedArray<float3 , 5>  _S1487 = points_13;
                points_13[int(0)] = points_13[int(0)];
                points_13[int(1)] = _S1484[int(1)];
                points_13[int(2)] = _S1485[int(2)];
                points_13[int(3)] = _S1486[int(3)];
                points_13[int(4)] = _S1487[int(4)];
                _S1411 = _S1408;
                _S1412 = _S1408;
                _S1467 = _S1442;
            }
            float3  _S1488 = _S1413 * (points_13[int(1)] + _S1411);
            float _S1489 = _S1488.x + _S1488.y + _S1488.z;
            float3  _S1490 = points_13[int(0)] + _S1412;
            float4  _S1491 = _S1442;
            *&((&_S1491)->y) = _S1489;
            float4  _S1492 = _S1467 + _S1491;
            points_13[int(0)] = _S1408;
            points_13[int(1)] = _S1408;
            points_13[int(2)] = _S1408;
            points_13[int(3)] = _S1408;
            points_13[int(4)] = _S1408;
            _S1411 = _S1490;
            _S1467 = _S1492;
        }
        else
        {
            FixedArray<float3 , 5>  _S1493 = points_13;
            FixedArray<float3 , 5>  _S1494 = points_13;
            FixedArray<float3 , 5>  _S1495 = points_13;
            FixedArray<float3 , 5>  _S1496 = points_13;
            points_13[int(0)] = points_13[int(0)];
            points_13[int(1)] = _S1493[int(1)];
            points_13[int(2)] = _S1494[int(2)];
            points_13[int(3)] = _S1495[int(3)];
            points_13[int(4)] = _S1496[int(4)];
            _S1411 = _S1408;
            _S1467 = _S1442;
        }
        float3  _S1497 = _S1414 * (points_13[int(0)] + _S1411);
        float _S1498 = _S1497.x + _S1497.y + _S1497.z;
        float4  _S1499 = _S1442;
        *&((&_S1499)->x) = _S1498;
        _S1467 = _S1467 + _S1499;
    }
    else
    {
        _S1467 = _S1442;
    }
    *v_depths_5 = _S1467;
    *v_gt_normal_2 = raydir_22;
    return;
}

inline __device__ float3  generate_ray_d2n_polar(float2  pix_pos_9, float4  intrins_24, FixedArray<float, 58>  dist_coeffs_28, int camera_model_26, bool is_ray_depth_23)
{
    float3  _S1500;
    for(;;)
    {
        float2  uv_74 = (pix_pos_9 - float2 {intrins_24.z, intrins_24.w}) / float2 {intrins_24.x, intrins_24.y};
        FixedArray<float, 58>  _S1501 = dist_coeffs_28;
        float2  uv_u_36;
        bool _S1502 = undistort_point_3(uv_74, &_S1501, int(12), &uv_u_36);
        if(!_S1502)
        {
            int3  _S1503 = make_int3 (int(0));
            float3  _S1504 = make_float3 ((float)_S1503.x, (float)_S1503.y, (float)_S1503.z);
            _S1500 = _S1504;
            break;
        }
        _S1500 = unproject_raydir_0(uv_u_36, camera_model_26, is_ray_depth_23);
        break;
    }
    return _S1500;
}

inline __device__ float3  depth_to_point_polar(float2  pix_pos_10, float4  intrins_25, FixedArray<float, 58>  dist_coeffs_29, int camera_model_27, bool is_ray_depth_24, float depth_8)
{
    float3  _S1505;
    for(;;)
    {
        float2  uv_75 = (pix_pos_10 - float2 {intrins_25.z, intrins_25.w}) / float2 {intrins_25.x, intrins_25.y};
        FixedArray<float, 58>  _S1506 = dist_coeffs_29;
        float2  uv_u_37;
        bool _S1507 = undistort_point_3(uv_75, &_S1506, int(12), &uv_u_37);
        if(!_S1507)
        {
            _S1505 = make_float3 (0.0f);
            break;
        }
        _S1505 = make_float3 (depth_8) * unproject_raydir_0(uv_u_37, camera_model_27, is_ray_depth_24);
        break;
    }
    return _S1505;
}

struct s_bwd_prop_depth_to_point_Intermediates_3
{
    float2  _S1508;
    bool _S1509;
};

inline __device__ float depth_to_point_vjp_polar(float2  pix_pos_11, float4  intrins_26, FixedArray<float, 58>  dist_coeffs_30, int camera_model_28, bool is_ray_depth_25, float depth_9, float3  v_point_3)
{
    float2  _S1510 = make_float2 (0.0f);
    s_bwd_prop_depth_to_point_Intermediates_3 _S1511;
    (&_S1511)->_S1508 = _S1510;
    (&_S1511)->_S1509 = false;
    float2  uv_76 = (pix_pos_11 - float2 {intrins_26.z, intrins_26.w}) / float2 {intrins_26.x, intrins_26.y};
    float2  _S1512 = _S1510;
    FixedArray<float, 58>  _S1513 = dist_coeffs_30;
    bool _S1514 = undistort_point_3(uv_76, &_S1513, int(12), &_S1512);
    (&_S1511)->_S1508 = _S1512;
    (&_S1511)->_S1509 = _S1514;
    s_bwd_prop_depth_to_point_Intermediates_3 _S1515 = _S1511;
    float3  _S1516 = make_float3 (0.0f);
    bool _S1517 = !!_S1511._S1509;
    float3  _S1518;
    if(_S1517)
    {
        _S1518 = s_primal_ctx_unproject_raydir_0(_S1515._S1508, camera_model_28, is_ray_depth_25);
    }
    else
    {
        _S1518 = _S1516;
    }
    if(_S1517)
    {
        _S1518 = _S1518 * v_point_3;
    }
    else
    {
        _S1518 = _S1516;
    }
    return _S1518.x + _S1518.y + _S1518.z;
}

inline __device__ float3  depth_to_normal_polar(float2  pix_center_15, float4  intrins_27, FixedArray<float, 58>  dist_coeffs_31, int camera_model_29, bool is_ray_depth_26, float4  depths_12)
{
    float3  normal_17;
    for(;;)
    {
        bool _S1519;
        if((depths_12.x) == 0.0f)
        {
            _S1519 = true;
        }
        else
        {
            _S1519 = (depths_12.y) == 0.0f;
        }
        if(_S1519)
        {
            _S1519 = true;
        }
        else
        {
            _S1519 = (depths_12.z) == 0.0f;
        }
        if(_S1519)
        {
            _S1519 = true;
        }
        else
        {
            _S1519 = (depths_12.w) == 0.0f;
        }
        if(_S1519)
        {
            normal_17 = make_float3 (0.0f);
            break;
        }
        float3  * _S1520;
        float3  * _S1521;
        float3  * _S1522;
        float3  * _S1523;
        int _S1524;
        FixedArray<float3 , 4>  points_14;
        for(;;)
        {
            float2  _S1525 = float2 {intrins_27.z, intrins_27.w};
            float2  _S1526 = float2 {intrins_27.x, intrins_27.y};
            float2  uv_77 = (pix_center_15 + make_float2 (-1.0f, -0.0f) - _S1525) / _S1526;
            FixedArray<float, 58>  _S1527 = dist_coeffs_31;
            float2  uv_u_38;
            bool _S1528 = undistort_point_3(uv_77, &_S1527, int(12), &uv_u_38);
            if(!_S1528)
            {
                float3  _S1529 = make_float3 (0.0f);
                _S1524 = int(0);
                _S1523 = nullptr;
                _S1522 = nullptr;
                _S1521 = nullptr;
                _S1520 = nullptr;
                normal_17 = _S1529;
                break;
            }
            points_14[int(0)] = make_float3 (depths_12.x) * unproject_raydir_0(uv_u_38, camera_model_29, is_ray_depth_26);
            for(;;)
            {
                float2  uv_78 = (pix_center_15 + make_float2 (1.0f, -0.0f) - _S1525) / _S1526;
                FixedArray<float, 58>  _S1530 = dist_coeffs_31;
                float2  uv_u_39;
                bool _S1531 = undistort_point_3(uv_78, &_S1530, int(12), &uv_u_39);
                if(!_S1531)
                {
                    float3  _S1532 = make_float3 (0.0f);
                    _S1524 = int(0);
                    _S1523 = nullptr;
                    normal_17 = _S1532;
                    break;
                }
                points_14[int(1)] = make_float3 (depths_12.y) * unproject_raydir_0(uv_u_39, camera_model_29, is_ray_depth_26);
                _S1524 = int(2);
                _S1523 = &points_14[int(1)];
                break;
            }
            if(_S1524 != int(2))
            {
                _S1522 = &points_14[int(0)];
                _S1521 = nullptr;
                _S1520 = nullptr;
                break;
            }
            float2  uv_79 = (pix_center_15 + make_float2 (0.0f, -1.0f) - _S1525) / _S1526;
            FixedArray<float, 58>  _S1533 = dist_coeffs_31;
            float2  uv_u_40;
            bool _S1534 = undistort_point_3(uv_79, &_S1533, int(12), &uv_u_40);
            if(!_S1534)
            {
                float3  _S1535 = make_float3 (0.0f);
                _S1524 = int(0);
                _S1522 = &points_14[int(0)];
                _S1521 = nullptr;
                _S1520 = nullptr;
                normal_17 = _S1535;
                break;
            }
            points_14[int(2)] = make_float3 (depths_12.z) * unproject_raydir_0(uv_u_40, camera_model_29, is_ray_depth_26);
            for(;;)
            {
                float2  uv_80 = (pix_center_15 + make_float2 (0.0f, 1.0f) - _S1525) / _S1526;
                FixedArray<float, 58>  _S1536 = dist_coeffs_31;
                float2  uv_u_41;
                bool _S1537 = undistort_point_3(uv_80, &_S1536, int(12), &uv_u_41);
                if(!_S1537)
                {
                    float3  _S1538 = make_float3 (0.0f);
                    _S1524 = int(0);
                    _S1522 = nullptr;
                    normal_17 = _S1538;
                    break;
                }
                points_14[int(3)] = make_float3 (depths_12.w) * unproject_raydir_0(uv_u_41, camera_model_29, is_ray_depth_26);
                _S1524 = int(2);
                _S1522 = &points_14[int(3)];
                break;
            }
            if(_S1524 != int(2))
            {
                float3  * _S1539 = _S1522;
                _S1522 = &points_14[int(0)];
                _S1521 = _S1539;
                _S1520 = &points_14[int(2)];
                break;
            }
            float3  * _S1540 = _S1522;
            _S1524 = int(1);
            _S1522 = &points_14[int(0)];
            _S1521 = _S1540;
            _S1520 = &points_14[int(2)];
            break;
        }
        if(_S1524 != int(1))
        {
            break;
        }
        float3  normal_18 = cross_0(*_S1523 - *_S1522, - (*_S1521 - *_S1520));
        if((dot_0(normal_18, normal_18)) != 0.0f)
        {
            normal_17 = normal_18 / make_float3 (length_0(normal_18));
        }
        else
        {
            normal_17 = normal_18;
        }
        break;
    }
    return normal_17;
}

struct s_bwd_prop_depth_to_normal_Intermediates_3
{
    float2  _S1541;
    bool _S1542;
    float2  _S1543;
    bool _S1544;
    float2  _S1545;
    bool _S1546;
    float2  _S1547;
    bool _S1548;
};

inline __device__ void depth_to_normal_vjp_polar(float2  pix_center_16, float4  intrins_28, FixedArray<float, 58>  dist_coeffs_32, int camera_model_30, bool is_ray_depth_27, float4  depths_13, float3  v_normal_4, float4  * v_depths_6)
{
    float2  _S1549 = make_float2 (0.0f);
    s_bwd_prop_depth_to_normal_Intermediates_3 _S1550;
    (&_S1550)->_S1541 = _S1549;
    (&_S1550)->_S1542 = false;
    (&_S1550)->_S1543 = _S1549;
    (&_S1550)->_S1544 = false;
    (&_S1550)->_S1545 = _S1549;
    (&_S1550)->_S1546 = false;
    (&_S1550)->_S1547 = _S1549;
    (&_S1550)->_S1548 = false;
    (&_S1550)->_S1541 = _S1549;
    (&_S1550)->_S1542 = false;
    (&_S1550)->_S1543 = _S1549;
    (&_S1550)->_S1544 = false;
    (&_S1550)->_S1545 = _S1549;
    (&_S1550)->_S1546 = false;
    (&_S1550)->_S1547 = _S1549;
    (&_S1550)->_S1548 = false;
    bool _S1551 = (depths_13.x) == 0.0f;
    bool _runFlag_27;
    if(_S1551)
    {
        _runFlag_27 = true;
    }
    else
    {
        _runFlag_27 = (depths_13.y) == 0.0f;
    }
    if(_runFlag_27)
    {
        _runFlag_27 = true;
    }
    else
    {
        _runFlag_27 = (depths_13.z) == 0.0f;
    }
    if(_runFlag_27)
    {
        _runFlag_27 = true;
    }
    else
    {
        _runFlag_27 = (depths_13.w) == 0.0f;
    }
    int _S1552;
    if(!_runFlag_27)
    {
        float2  _S1553 = float2 {intrins_28.z, intrins_28.w};
        float2  _S1554 = float2 {intrins_28.x, intrins_28.y};
        float2  uv_81 = (pix_center_16 + make_float2 (-1.0f, -0.0f) - _S1553) / _S1554;
        float2  _S1555 = _S1549;
        FixedArray<float, 58>  _S1556 = dist_coeffs_32;
        bool _S1557 = undistort_point_3(uv_81, &_S1556, int(12), &_S1555);
        (&_S1550)->_S1541 = _S1555;
        (&_S1550)->_S1542 = _S1557;
        bool _S1558 = !!_S1557;
        if(_S1558)
        {
            float2  uv_82 = (pix_center_16 + make_float2 (1.0f, -0.0f) - _S1553) / _S1554;
            float2  _S1559 = _S1549;
            FixedArray<float, 58>  _S1560 = dist_coeffs_32;
            bool _S1561 = undistort_point_3(uv_82, &_S1560, int(12), &_S1559);
            (&_S1550)->_S1543 = _S1559;
            (&_S1550)->_S1544 = _S1561;
            if(!!_S1561)
            {
                _S1552 = int(2);
            }
            else
            {
                _S1552 = int(0);
            }
            if(_S1552 != int(2))
            {
                _runFlag_27 = false;
            }
            else
            {
                _runFlag_27 = _S1558;
            }
            if(_runFlag_27)
            {
                float2  uv_83 = (pix_center_16 + make_float2 (0.0f, -1.0f) - _S1553) / _S1554;
                float2  _S1562 = _S1549;
                FixedArray<float, 58>  _S1563 = dist_coeffs_32;
                bool _S1564 = undistort_point_3(uv_83, &_S1563, int(12), &_S1562);
                (&_S1550)->_S1545 = _S1562;
                (&_S1550)->_S1546 = _S1564;
                if(!_S1564)
                {
                    _runFlag_27 = false;
                }
                if(_runFlag_27)
                {
                    float2  uv_84 = (pix_center_16 + make_float2 (0.0f, 1.0f) - _S1553) / _S1554;
                    float2  _S1565 = _S1549;
                    FixedArray<float, 58>  _S1566 = dist_coeffs_32;
                    bool _S1567 = undistort_point_3(uv_84, &_S1566, int(12), &_S1565);
                    (&_S1550)->_S1547 = _S1565;
                    (&_S1550)->_S1548 = _S1567;
                }
            }
        }
    }
    s_bwd_prop_depth_to_normal_Intermediates_3 _S1568 = _S1550;
    float3  _S1569 = make_float3 (0.0f);
    if(_S1551)
    {
        _runFlag_27 = true;
    }
    else
    {
        _runFlag_27 = (depths_13.y) == 0.0f;
    }
    if(_runFlag_27)
    {
        _runFlag_27 = true;
    }
    else
    {
        _runFlag_27 = (depths_13.z) == 0.0f;
    }
    if(_runFlag_27)
    {
        _runFlag_27 = true;
    }
    else
    {
        _runFlag_27 = (depths_13.w) == 0.0f;
    }
    bool _S1570 = !_runFlag_27;
    bool _runFlag_28;
    bool _runFlag_29;
    bool _S1571;
    bool _runFlag_30;
    bool _S1572;
    bool _S1573;
    FixedArray<float3 , 4>  points_15;
    float3  _S1574;
    float3  _S1575;
    float3  _S1576;
    float3  _S1577;
    float3  _S1578;
    float3  _S1579;
    float3  _S1580;
    float3  _S1581;
    float3  _S1582;
    if(_S1570)
    {
        bool _S1583 = !!_S1568._S1542;
        if(_S1583)
        {
            float3  _S1584 = s_primal_ctx_unproject_raydir_0(_S1568._S1541, camera_model_30, is_ray_depth_27);
            float3  _S1585 = make_float3 (depths_13.x) * _S1584;
            bool _S1586 = !!_S1568._S1544;
            if(_S1586)
            {
                float3  _S1587 = s_primal_ctx_unproject_raydir_0(_S1568._S1543, camera_model_30, is_ray_depth_27);
                float3  _S1588 = make_float3 (depths_13.y) * _S1587;
                _S1552 = int(2);
                points_15[int(0)] = _S1585;
                points_15[int(1)] = _S1588;
                points_15[int(2)] = _S1569;
                points_15[int(3)] = _S1569;
                _S1574 = _S1587;
            }
            else
            {
                _S1552 = int(0);
                points_15[int(0)] = _S1585;
                points_15[int(1)] = _S1569;
                points_15[int(2)] = _S1569;
                points_15[int(3)] = _S1569;
                _S1574 = _S1569;
            }
            if(_S1552 != int(2))
            {
                _runFlag_27 = false;
            }
            else
            {
                _runFlag_27 = _S1583;
                _S1552 = int(0);
            }
            if(_runFlag_27)
            {
                if(!_S1568._S1546)
                {
                    _runFlag_28 = false;
                    _S1552 = int(0);
                }
                else
                {
                    _runFlag_28 = _runFlag_27;
                }
                if(_runFlag_28)
                {
                    float3  _S1589 = s_primal_ctx_unproject_raydir_0(_S1568._S1545, camera_model_30, is_ray_depth_27);
                    points_15[int(2)] = make_float3 (depths_13.z) * _S1589;
                    bool _S1590 = !!_S1568._S1548;
                    int _S1591;
                    if(_S1590)
                    {
                        float3  _S1592 = s_primal_ctx_unproject_raydir_0(_S1568._S1547, camera_model_30, is_ray_depth_27);
                        points_15[int(3)] = make_float3 (depths_13.w) * _S1592;
                        _S1591 = int(2);
                        _S1575 = _S1592;
                    }
                    else
                    {
                        _S1591 = int(0);
                        _S1575 = _S1569;
                    }
                    if(_S1591 != int(2))
                    {
                        _runFlag_29 = false;
                        _S1552 = _S1591;
                    }
                    else
                    {
                        _runFlag_29 = _runFlag_28;
                    }
                    if(_runFlag_29)
                    {
                        _S1552 = int(1);
                    }
                    _runFlag_29 = _S1590;
                    _S1576 = _S1589;
                }
                else
                {
                    _runFlag_29 = false;
                    _S1575 = _S1569;
                    _S1576 = _S1569;
                }
            }
            else
            {
                _runFlag_28 = false;
                _runFlag_29 = false;
                _S1575 = _S1569;
                _S1576 = _S1569;
            }
            float3  _S1593 = _S1574;
            _S1574 = _S1575;
            _S1575 = _S1576;
            _S1571 = _S1586;
            _S1576 = _S1593;
            _S1577 = _S1584;
        }
        else
        {
            _S1552 = int(0);
            points_15[int(0)] = _S1569;
            points_15[int(1)] = _S1569;
            points_15[int(2)] = _S1569;
            points_15[int(3)] = _S1569;
            _runFlag_27 = false;
            _runFlag_28 = false;
            _runFlag_29 = false;
            _S1574 = _S1569;
            _S1575 = _S1569;
            _S1571 = false;
            _S1576 = _S1569;
            _S1577 = _S1569;
        }
        if(_S1552 != int(1))
        {
            _runFlag_30 = false;
        }
        else
        {
            _runFlag_30 = _S1570;
        }
        if(_runFlag_30)
        {
            float3  dx_7 = points_15[int(1)] - points_15[int(0)];
            float3  _S1594 = - (points_15[int(3)] - points_15[int(2)]);
            float3  _S1595 = s_primal_ctx_cross_0(dx_7, _S1594);
            bool _S1596 = (s_primal_ctx_dot_0(_S1595, _S1595)) != 0.0f;
            if(_S1596)
            {
                float _S1597 = length_0(_S1595);
                float3  _S1598 = make_float3 (_S1597);
                _S1578 = make_float3 (_S1597 * _S1597);
                _S1579 = _S1598;
            }
            else
            {
                _S1578 = _S1569;
                _S1579 = _S1569;
            }
            float3  _S1599 = _S1579;
            _S1572 = _S1596;
            _S1579 = _S1595;
            _S1580 = _S1599;
            _S1581 = dx_7;
            _S1582 = _S1594;
        }
        else
        {
            _S1572 = false;
            _S1578 = _S1569;
            _S1579 = _S1569;
            _S1580 = _S1569;
            _S1581 = _S1569;
            _S1582 = _S1569;
        }
        bool _S1600 = _runFlag_27;
        bool _S1601 = _runFlag_28;
        bool _S1602 = _runFlag_29;
        float3  _S1603 = _S1574;
        float3  _S1604 = _S1575;
        bool _S1605 = _S1571;
        float3  _S1606 = _S1576;
        float3  _S1607 = _S1577;
        _runFlag_27 = _runFlag_30;
        _runFlag_28 = _S1572;
        _S1574 = _S1578;
        _S1575 = _S1579;
        _S1576 = _S1580;
        _S1577 = _S1581;
        _S1578 = _S1582;
        _runFlag_29 = _S1583;
        _S1571 = _S1600;
        _runFlag_30 = _S1601;
        _S1572 = _S1602;
        _S1579 = _S1603;
        _S1580 = _S1604;
        _S1573 = _S1605;
        _S1581 = _S1606;
        _S1582 = _S1607;
    }
    else
    {
        _runFlag_27 = false;
        _runFlag_28 = false;
        _S1574 = _S1569;
        _S1575 = _S1569;
        _S1576 = _S1569;
        _S1577 = _S1569;
        _S1578 = _S1569;
        _runFlag_29 = false;
        _S1571 = false;
        _runFlag_30 = false;
        _S1572 = false;
        _S1579 = _S1569;
        _S1580 = _S1569;
        _S1573 = false;
        _S1581 = _S1569;
        _S1582 = _S1569;
    }
    float4  _S1608 = make_float4 (0.0f);
    float4  _S1609;
    if(_S1570)
    {
        if(_runFlag_27)
        {
            if(_runFlag_28)
            {
                float3  _S1610 = v_normal_4 / _S1574;
                float3  _S1611 = _S1575 * - _S1610;
                float3  _S1612 = _S1576 * _S1610;
                float _S1613 = _S1611.x + _S1611.y + _S1611.z;
                DiffPair_vectorx3Cfloatx2C3x3E_0 _S1614;
                (&_S1614)->primal_0 = _S1575;
                (&_S1614)->differential_0 = _S1569;
                s_bwd_length_impl_0(&_S1614, _S1613);
                _S1574 = _S1612 + _S1614.differential_0;
            }
            else
            {
                _S1574 = v_normal_4;
            }
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1615;
            (&_S1615)->primal_0 = _S1575;
            (&_S1615)->differential_0 = _S1569;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1616;
            (&_S1616)->primal_0 = _S1575;
            (&_S1616)->differential_0 = _S1569;
            s_bwd_prop_dot_0(&_S1615, &_S1616, 0.0f);
            float3  _S1617 = _S1616.differential_0 + _S1615.differential_0 + _S1574;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1618;
            (&_S1618)->primal_0 = _S1577;
            (&_S1618)->differential_0 = _S1569;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1619;
            (&_S1619)->primal_0 = _S1578;
            (&_S1619)->differential_0 = _S1569;
            s_bwd_prop_cross_0(&_S1618, &_S1619, _S1617);
            float3  s_diff_dy_T_7 = - _S1619.differential_0;
            float3  _S1620 = - s_diff_dy_T_7;
            float3  _S1621 = - _S1618.differential_0;
            FixedArray<float3 , 4>  _S1622;
            _S1622[int(0)] = _S1569;
            _S1622[int(1)] = _S1569;
            _S1622[int(2)] = _S1569;
            _S1622[int(3)] = _S1569;
            _S1622[int(2)] = _S1620;
            _S1622[int(3)] = s_diff_dy_T_7;
            _S1622[int(0)] = _S1621;
            _S1622[int(1)] = _S1618.differential_0;
            points_15[int(0)] = _S1622[int(0)];
            points_15[int(1)] = _S1622[int(1)];
            points_15[int(2)] = _S1622[int(2)];
            points_15[int(3)] = _S1622[int(3)];
        }
        else
        {
            points_15[int(0)] = _S1569;
            points_15[int(1)] = _S1569;
            points_15[int(2)] = _S1569;
            points_15[int(3)] = _S1569;
        }
        if(_runFlag_29)
        {
            if(_S1571)
            {
                if(_runFlag_30)
                {
                    FixedArray<float3 , 4>  _S1623 = points_15;
                    FixedArray<float3 , 4>  _S1624 = points_15;
                    FixedArray<float3 , 4>  _S1625 = points_15;
                    FixedArray<float3 , 4>  _S1626 = points_15;
                    if(_S1572)
                    {
                        float3  _S1627 = _S1579 * _S1626[int(3)];
                        float _S1628 = _S1627.x + _S1627.y + _S1627.z;
                        float4  _S1629 = _S1608;
                        *&((&_S1629)->w) = _S1628;
                        points_15[int(0)] = _S1623[int(0)];
                        points_15[int(1)] = _S1624[int(1)];
                        points_15[int(2)] = _S1625[int(2)];
                        points_15[int(3)] = _S1569;
                        _S1609 = _S1629;
                    }
                    else
                    {
                        points_15[int(0)] = _S1623[int(0)];
                        points_15[int(1)] = _S1624[int(1)];
                        points_15[int(2)] = _S1625[int(2)];
                        points_15[int(3)] = _S1626[int(3)];
                        _S1609 = _S1608;
                    }
                    float3  _S1630 = _S1580 * points_15[int(2)];
                    float _S1631 = _S1630.x + _S1630.y + _S1630.z;
                    FixedArray<float3 , 4>  _S1632 = points_15;
                    FixedArray<float3 , 4>  _S1633 = points_15;
                    float4  _S1634 = _S1608;
                    *&((&_S1634)->z) = _S1631;
                    float4  _S1635 = _S1609 + _S1634;
                    points_15[int(0)] = points_15[int(0)];
                    points_15[int(1)] = _S1632[int(1)];
                    points_15[int(2)] = _S1569;
                    points_15[int(3)] = _S1633[int(3)];
                    _S1609 = _S1635;
                }
                else
                {
                    FixedArray<float3 , 4>  _S1636 = points_15;
                    FixedArray<float3 , 4>  _S1637 = points_15;
                    FixedArray<float3 , 4>  _S1638 = points_15;
                    points_15[int(0)] = points_15[int(0)];
                    points_15[int(1)] = _S1636[int(1)];
                    points_15[int(2)] = _S1637[int(2)];
                    points_15[int(3)] = _S1638[int(3)];
                    _S1609 = _S1608;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S1639 = points_15;
                FixedArray<float3 , 4>  _S1640 = points_15;
                FixedArray<float3 , 4>  _S1641 = points_15;
                points_15[int(0)] = points_15[int(0)];
                points_15[int(1)] = _S1639[int(1)];
                points_15[int(2)] = _S1640[int(2)];
                points_15[int(3)] = _S1641[int(3)];
                _S1609 = _S1608;
            }
            if(_S1573)
            {
                FixedArray<float3 , 4>  _S1642 = points_15;
                float3  _S1643 = _S1581 * points_15[int(1)];
                float _S1644 = _S1643.x + _S1643.y + _S1643.z;
                float4  _S1645 = _S1608;
                *&((&_S1645)->y) = _S1644;
                float4  _S1646 = _S1609 + _S1645;
                points_15[int(0)] = _S1569;
                points_15[int(1)] = _S1569;
                points_15[int(2)] = _S1569;
                points_15[int(3)] = _S1569;
                _S1574 = _S1642[int(0)];
                _S1609 = _S1646;
            }
            else
            {
                FixedArray<float3 , 4>  _S1647 = points_15;
                FixedArray<float3 , 4>  _S1648 = points_15;
                FixedArray<float3 , 4>  _S1649 = points_15;
                points_15[int(0)] = points_15[int(0)];
                points_15[int(1)] = _S1647[int(1)];
                points_15[int(2)] = _S1648[int(2)];
                points_15[int(3)] = _S1649[int(3)];
                _S1574 = _S1569;
            }
            float3  _S1650 = _S1582 * (points_15[int(0)] + _S1574);
            float _S1651 = _S1650.x + _S1650.y + _S1650.z;
            float4  _S1652 = _S1608;
            *&((&_S1652)->x) = _S1651;
            _S1609 = _S1609 + _S1652;
        }
        else
        {
            _S1609 = _S1608;
        }
    }
    else
    {
        _S1609 = _S1608;
    }
    *v_depths_6 = _S1609;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_polar(float2  pix_center_17, float4  intrins_29, FixedArray<float, 58>  dist_coeffs_33, int camera_model_31)
{
    float _S1653;
    for(;;)
    {
        float2  uv_85 = (pix_center_17 - float2 {intrins_29.z, intrins_29.w}) / float2 {intrins_29.x, intrins_29.y};
        FixedArray<float, 58>  _S1654 = dist_coeffs_33;
        float2  uv_u_42;
        bool _S1655 = undistort_point_3(uv_85, &_S1654, int(12), &uv_u_42);
        if(!_S1655)
        {
            _S1653 = 0.0f;
            break;
        }
        float3  raydir_23 = unproject_raydir_0(uv_u_42, camera_model_31, false);
        _S1653 = float((F32_sign((raydir_23.z)))) / length_0(raydir_23);
        break;
    }
    return _S1653;
}

inline __device__ float depth_normal_loss_polar(float2  pix_center_18, float4  intrins_30, FixedArray<float, 58>  dist_coeffs_34, int camera_model_32, bool is_ray_depth_28, float4  depths_14, float3  gt_normal_6)
{
    float _S1656;
    for(;;)
    {
        float3  _S1657;
        float3  * _S1658;
        float3  * _S1659;
        float3  * _S1660;
        float3  * _S1661;
        int _S1662;
        FixedArray<float3 , 5>  points_16;
        for(;;)
        {
            float2  _S1663 = float2 {intrins_30.z, intrins_30.w};
            float2  _S1664 = float2 {intrins_30.x, intrins_30.y};
            float2  uv_86 = (pix_center_18 + make_float2 (-1.0f, -0.0f) - _S1663) / _S1664;
            FixedArray<float, 58>  _S1665 = dist_coeffs_34;
            float2  uv_u_43;
            bool _S1666 = undistort_point_3(uv_86, &_S1665, int(12), &uv_u_43);
            float3  _S1667 = make_float3 (0.0f);
            if(!_S1666)
            {
                _S1662 = int(0);
                _S1661 = nullptr;
                _S1660 = nullptr;
                _S1659 = nullptr;
                _S1658 = nullptr;
                _S1657 = _S1667;
                break;
            }
            float3  raydir_24 = unproject_raydir_0(uv_u_43, camera_model_32, is_ray_depth_28);
            points_16[int(0)] = make_float3 (depths_14.x) * raydir_24;
            float2  uv_87 = (pix_center_18 + make_float2 (1.0f, -0.0f) - _S1663) / _S1664;
            FixedArray<float, 58>  _S1668 = dist_coeffs_34;
            float2  uv_u_44;
            bool _S1669 = undistort_point_3(uv_87, &_S1668, int(12), &uv_u_44);
            if(!_S1669)
            {
                _S1662 = int(0);
                _S1661 = nullptr;
                _S1660 = &points_16[int(0)];
                _S1659 = nullptr;
                _S1658 = nullptr;
                _S1657 = _S1667;
                break;
            }
            float3  raydir_25 = unproject_raydir_0(uv_u_44, camera_model_32, is_ray_depth_28);
            points_16[int(1)] = make_float3 (depths_14.y) * raydir_25;
            float2  uv_88 = (pix_center_18 + make_float2 (0.0f, -1.0f) - _S1663) / _S1664;
            FixedArray<float, 58>  _S1670 = dist_coeffs_34;
            float2  uv_u_45;
            bool _S1671 = undistort_point_3(uv_88, &_S1670, int(12), &uv_u_45);
            if(!_S1671)
            {
                _S1662 = int(0);
                _S1661 = &points_16[int(1)];
                _S1660 = &points_16[int(0)];
                _S1659 = nullptr;
                _S1658 = nullptr;
                _S1657 = _S1667;
                break;
            }
            float3  raydir_26 = unproject_raydir_0(uv_u_45, camera_model_32, is_ray_depth_28);
            points_16[int(2)] = make_float3 (depths_14.z) * raydir_26;
            float2  uv_89 = (pix_center_18 + make_float2 (0.0f, 1.0f) - _S1663) / _S1664;
            FixedArray<float, 58>  _S1672 = dist_coeffs_34;
            float2  uv_u_46;
            bool _S1673 = undistort_point_3(uv_89, &_S1672, int(12), &uv_u_46);
            if(!_S1673)
            {
                _S1662 = int(0);
                _S1661 = &points_16[int(1)];
                _S1660 = &points_16[int(0)];
                _S1659 = nullptr;
                _S1658 = &points_16[int(2)];
                _S1657 = _S1667;
                break;
            }
            float3  raydir_27 = unproject_raydir_0(uv_u_46, camera_model_32, is_ray_depth_28);
            points_16[int(3)] = make_float3 (depths_14.w) * raydir_27;
            float2  uv_90 = (pix_center_18 + make_float2 (0.0f) * make_float2 (0.0f, 3.0f) - _S1663) / _S1664;
            FixedArray<float, 58>  _S1674 = dist_coeffs_34;
            float2  uv_u_47;
            bool _S1675 = undistort_point_3(uv_90, &_S1674, int(12), &uv_u_47);
            if(!_S1675)
            {
                _S1662 = int(0);
                _S1661 = &points_16[int(1)];
                _S1660 = &points_16[int(0)];
                _S1659 = &points_16[int(3)];
                _S1658 = &points_16[int(2)];
                _S1657 = _S1667;
                break;
            }
            float3  raydir_28 = unproject_raydir_0(uv_u_47, camera_model_32, is_ray_depth_28);
            _S1662 = int(1);
            _S1661 = &points_16[int(1)];
            _S1660 = &points_16[int(0)];
            _S1659 = &points_16[int(3)];
            _S1658 = &points_16[int(2)];
            _S1657 = raydir_28;
            break;
        }
        if(_S1662 != int(1))
        {
            _S1656 = 0.0f;
            break;
        }
        float3  normal_19 = cross_0(*_S1661 - *_S1660, - (*_S1659 - *_S1658));
        float3  normal_20;
        if((dot_0(normal_19, normal_19)) != 0.0f)
        {
            normal_20 = normalize_0(normal_19);
        }
        else
        {
            normal_20 = normal_19;
        }
        float3  _S1676;
        if((dot_0(gt_normal_6, gt_normal_6)) != 0.0f)
        {
            _S1676 = normalize_0(gt_normal_6);
        }
        else
        {
            _S1676 = gt_normal_6;
        }
        _S1656 = (1.0f - dot_0(normal_20, _S1676) + 0.00100000004749745f) / ((F32_max((dot_0(normal_20, - normalize_0(_S1657))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S1656;
}

struct s_bwd_prop_depth_normal_loss_Intermediates_3
{
    float2  _S1677;
    bool _S1678;
    float2  _S1679;
    bool _S1680;
    float2  _S1681;
    bool _S1682;
    float2  _S1683;
    bool _S1684;
    float2  _S1685;
    bool _S1686;
};

inline __device__ void depth_normal_loss_vjp_polar(float2  pix_center_19, float4  intrins_31, FixedArray<float, 58>  dist_coeffs_35, int camera_model_33, bool is_ray_depth_29, float4  depths_15, float3  gt_normal_7, float v_loss_3, float4  * v_depths_7, float3  * v_gt_normal_3)
{
    float2  _S1687 = make_float2 (0.0f);
    s_bwd_prop_depth_normal_loss_Intermediates_3 _S1688;
    (&_S1688)->_S1677 = _S1687;
    (&_S1688)->_S1678 = false;
    (&_S1688)->_S1679 = _S1687;
    (&_S1688)->_S1680 = false;
    (&_S1688)->_S1681 = _S1687;
    (&_S1688)->_S1682 = false;
    (&_S1688)->_S1683 = _S1687;
    (&_S1688)->_S1684 = false;
    (&_S1688)->_S1685 = _S1687;
    (&_S1688)->_S1686 = false;
    (&_S1688)->_S1679 = _S1687;
    (&_S1688)->_S1680 = false;
    (&_S1688)->_S1681 = _S1687;
    (&_S1688)->_S1682 = false;
    (&_S1688)->_S1683 = _S1687;
    (&_S1688)->_S1684 = false;
    (&_S1688)->_S1685 = _S1687;
    (&_S1688)->_S1686 = false;
    float2  _S1689 = float2 {intrins_31.z, intrins_31.w};
    float2  _S1690 = float2 {intrins_31.x, intrins_31.y};
    float2  uv_91 = (pix_center_19 + make_float2 (-1.0f, -0.0f) - _S1689) / _S1690;
    float2  _S1691 = _S1687;
    FixedArray<float, 58>  _S1692 = dist_coeffs_35;
    bool _S1693 = undistort_point_3(uv_91, &_S1692, int(12), &_S1691);
    (&_S1688)->_S1677 = _S1691;
    (&_S1688)->_S1678 = _S1693;
    bool _S1694 = !!_S1693;
    bool _runFlag_31;
    if(_S1694)
    {
        float2  uv_92 = (pix_center_19 + make_float2 (1.0f, -0.0f) - _S1689) / _S1690;
        float2  _S1695 = _S1687;
        FixedArray<float, 58>  _S1696 = dist_coeffs_35;
        bool _S1697 = undistort_point_3(uv_92, &_S1696, int(12), &_S1695);
        (&_S1688)->_S1679 = _S1695;
        (&_S1688)->_S1680 = _S1697;
        if(!_S1697)
        {
            _runFlag_31 = false;
        }
        else
        {
            _runFlag_31 = _S1694;
        }
        if(_runFlag_31)
        {
            float2  uv_93 = (pix_center_19 + make_float2 (0.0f, -1.0f) - _S1689) / _S1690;
            float2  _S1698 = _S1687;
            FixedArray<float, 58>  _S1699 = dist_coeffs_35;
            bool _S1700 = undistort_point_3(uv_93, &_S1699, int(12), &_S1698);
            (&_S1688)->_S1681 = _S1698;
            (&_S1688)->_S1682 = _S1700;
            if(!_S1700)
            {
                _runFlag_31 = false;
            }
            if(_runFlag_31)
            {
                float2  uv_94 = (pix_center_19 + make_float2 (0.0f, 1.0f) - _S1689) / _S1690;
                float2  _S1701 = _S1687;
                FixedArray<float, 58>  _S1702 = dist_coeffs_35;
                bool _S1703 = undistort_point_3(uv_94, &_S1702, int(12), &_S1701);
                (&_S1688)->_S1683 = _S1701;
                (&_S1688)->_S1684 = _S1703;
                if(!_S1703)
                {
                    _runFlag_31 = false;
                }
                if(_runFlag_31)
                {
                    float2  uv_95 = (pix_center_19 - _S1689) / _S1690;
                    float2  _S1704 = _S1687;
                    FixedArray<float, 58>  _S1705 = dist_coeffs_35;
                    bool _S1706 = undistort_point_3(uv_95, &_S1705, int(12), &_S1704);
                    (&_S1688)->_S1685 = _S1704;
                    (&_S1688)->_S1686 = _S1706;
                }
            }
        }
    }
    s_bwd_prop_depth_normal_loss_Intermediates_3 _S1707 = _S1688;
    float3  _S1708 = make_float3 (0.0f);
    bool _S1709 = !!_S1688._S1678;
    bool _runFlag_32;
    bool _runFlag_33;
    bool _runFlag_34;
    int _S1710;
    float3  raydir_29;
    float3  _S1711;
    float3  _S1712;
    float3  _S1713;
    float3  _S1714;
    FixedArray<float3 , 5>  points_17;
    if(_S1709)
    {
        float3  _S1715 = s_primal_ctx_unproject_raydir_0(_S1707._S1677, camera_model_33, is_ray_depth_29);
        float3  _S1716 = make_float3 (depths_15.x) * _S1715;
        if(!_S1707._S1680)
        {
            _runFlag_31 = false;
        }
        else
        {
            _runFlag_31 = _S1709;
        }
        if(_runFlag_31)
        {
            float3  _S1717 = s_primal_ctx_unproject_raydir_0(_S1707._S1679, camera_model_33, is_ray_depth_29);
            float3  _S1718 = make_float3 (depths_15.y) * _S1717;
            if(!_S1707._S1682)
            {
                _runFlag_32 = false;
            }
            else
            {
                _runFlag_32 = _runFlag_31;
            }
            if(_runFlag_32)
            {
                float3  _S1719 = s_primal_ctx_unproject_raydir_0(_S1707._S1681, camera_model_33, is_ray_depth_29);
                float3  _S1720 = make_float3 (depths_15.z) * _S1719;
                if(!_S1707._S1684)
                {
                    _runFlag_33 = false;
                }
                else
                {
                    _runFlag_33 = _runFlag_32;
                }
                if(_runFlag_33)
                {
                    float3  _S1721 = s_primal_ctx_unproject_raydir_0(_S1707._S1683, camera_model_33, is_ray_depth_29);
                    float3  _S1722 = make_float3 (depths_15.w) * _S1721;
                    if(!_S1707._S1686)
                    {
                        _runFlag_34 = false;
                    }
                    else
                    {
                        _runFlag_34 = _runFlag_33;
                    }
                    if(_runFlag_34)
                    {
                        float3  _S1723 = s_primal_ctx_unproject_raydir_0(_S1707._S1685, camera_model_33, is_ray_depth_29);
                        _S1710 = int(1);
                        raydir_29 = _S1723;
                    }
                    else
                    {
                        _S1710 = int(0);
                        raydir_29 = _S1721;
                    }
                    points_17[int(0)] = _S1716;
                    points_17[int(1)] = _S1718;
                    points_17[int(2)] = _S1720;
                    points_17[int(3)] = _S1722;
                    points_17[int(4)] = _S1708;
                    _S1711 = _S1721;
                }
                else
                {
                    _S1710 = int(0);
                    raydir_29 = _S1719;
                    points_17[int(0)] = _S1716;
                    points_17[int(1)] = _S1718;
                    points_17[int(2)] = _S1720;
                    points_17[int(3)] = _S1708;
                    points_17[int(4)] = _S1708;
                    _S1711 = _S1708;
                }
                _S1712 = _S1719;
            }
            else
            {
                _S1710 = int(0);
                raydir_29 = _S1717;
                points_17[int(0)] = _S1716;
                points_17[int(1)] = _S1718;
                points_17[int(2)] = _S1708;
                points_17[int(3)] = _S1708;
                points_17[int(4)] = _S1708;
                _runFlag_33 = false;
                _S1711 = _S1708;
                _S1712 = _S1708;
            }
            _S1713 = _S1717;
        }
        else
        {
            _S1710 = int(0);
            raydir_29 = _S1715;
            points_17[int(0)] = _S1716;
            points_17[int(1)] = _S1708;
            points_17[int(2)] = _S1708;
            points_17[int(3)] = _S1708;
            points_17[int(4)] = _S1708;
            _runFlag_32 = false;
            _runFlag_33 = false;
            _S1711 = _S1708;
            _S1712 = _S1708;
            _S1713 = _S1708;
        }
        _S1714 = _S1715;
    }
    else
    {
        _S1710 = int(0);
        points_17[int(0)] = _S1708;
        points_17[int(1)] = _S1708;
        points_17[int(2)] = _S1708;
        points_17[int(3)] = _S1708;
        points_17[int(4)] = _S1708;
        _runFlag_31 = false;
        _runFlag_32 = false;
        _runFlag_33 = false;
        _S1711 = _S1708;
        _S1712 = _S1708;
        _S1713 = _S1708;
        _S1714 = _S1708;
    }
    bool _S1724 = !(_S1710 != int(1));
    bool _S1725;
    float3  normal_21;
    float3  _S1726;
    float3  _S1727;
    float3  _S1728;
    float3  _S1729;
    float _S1730;
    float _S1731;
    float _S1732;
    float _S1733;
    if(_S1724)
    {
        float3  dx_8 = points_17[int(1)] - points_17[int(0)];
        float3  _S1734 = - (points_17[int(3)] - points_17[int(2)]);
        float3  _S1735 = s_primal_ctx_cross_0(dx_8, _S1734);
        bool _S1736 = (s_primal_ctx_dot_0(_S1735, _S1735)) != 0.0f;
        if(_S1736)
        {
            normal_21 = normalize_0(_S1735);
        }
        else
        {
            normal_21 = _S1735;
        }
        bool _S1737 = (s_primal_ctx_dot_0(gt_normal_7, gt_normal_7)) != 0.0f;
        if(_S1737)
        {
            _S1726 = normalize_0(gt_normal_7);
        }
        else
        {
            _S1726 = gt_normal_7;
        }
        float3  _S1738 = - normalize_0(raydir_29);
        float _S1739 = s_primal_ctx_dot_0(normal_21, _S1738);
        float _S1740 = 1.0f - s_primal_ctx_dot_0(normal_21, _S1726) + 0.00100000004749745f;
        float _S1741 = (F32_max((_S1739), (0.0f))) + 0.00100000004749745f;
        _S1730 = _S1741 * _S1741;
        _S1731 = _S1740;
        _S1732 = _S1741;
        _S1733 = _S1739;
        raydir_29 = normal_21;
        normal_21 = _S1738;
        _runFlag_34 = _S1737;
        _S1725 = _S1736;
        _S1727 = _S1735;
        _S1728 = dx_8;
        _S1729 = _S1734;
    }
    else
    {
        _S1730 = 0.0f;
        _S1731 = 0.0f;
        _S1732 = 0.0f;
        _S1733 = 0.0f;
        raydir_29 = _S1708;
        normal_21 = _S1708;
        _S1726 = _S1708;
        _runFlag_34 = false;
        _S1725 = false;
        _S1727 = _S1708;
        _S1728 = _S1708;
        _S1729 = _S1708;
    }
    float4  _S1742 = make_float4 (0.0f);
    if(_S1724)
    {
        float _S1743 = v_loss_3 / _S1730;
        float _S1744 = _S1731 * - _S1743;
        float s_diff_num_T_3 = _S1732 * _S1743;
        DiffPair_float_0 _S1745;
        (&_S1745)->primal_0 = _S1733;
        (&_S1745)->differential_0 = 0.0f;
        DiffPair_float_0 _S1746;
        (&_S1746)->primal_0 = 0.0f;
        (&_S1746)->differential_0 = 0.0f;
        _d_max_0(&_S1745, &_S1746, _S1744);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1747;
        (&_S1747)->primal_0 = raydir_29;
        (&_S1747)->differential_0 = _S1708;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1748;
        (&_S1748)->primal_0 = normal_21;
        (&_S1748)->differential_0 = _S1708;
        s_bwd_prop_dot_0(&_S1747, &_S1748, _S1745.differential_0);
        float _S1749 = - s_diff_num_T_3;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1750;
        (&_S1750)->primal_0 = raydir_29;
        (&_S1750)->differential_0 = _S1708;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1751;
        (&_S1751)->primal_0 = _S1726;
        (&_S1751)->differential_0 = _S1708;
        s_bwd_prop_dot_0(&_S1750, &_S1751, _S1749);
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1752 = _S1751;
        float3  _S1753 = _S1747.differential_0 + _S1750.differential_0;
        if(_runFlag_34)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1754;
            (&_S1754)->primal_0 = gt_normal_7;
            (&_S1754)->differential_0 = _S1708;
            s_bwd_normalize_impl_0(&_S1754, _S1752.differential_0);
            raydir_29 = _S1754.differential_0;
        }
        else
        {
            raydir_29 = _S1752.differential_0;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1755;
        (&_S1755)->primal_0 = gt_normal_7;
        (&_S1755)->differential_0 = _S1708;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1756;
        (&_S1756)->primal_0 = gt_normal_7;
        (&_S1756)->differential_0 = _S1708;
        s_bwd_prop_dot_0(&_S1755, &_S1756, 0.0f);
        float3  _S1757 = _S1756.differential_0 + _S1755.differential_0 + raydir_29;
        if(_S1725)
        {
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1758;
            (&_S1758)->primal_0 = _S1727;
            (&_S1758)->differential_0 = _S1708;
            s_bwd_normalize_impl_0(&_S1758, _S1753);
            raydir_29 = _S1758.differential_0;
        }
        else
        {
            raydir_29 = _S1753;
        }
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1759;
        (&_S1759)->primal_0 = _S1727;
        (&_S1759)->differential_0 = _S1708;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1760;
        (&_S1760)->primal_0 = _S1727;
        (&_S1760)->differential_0 = _S1708;
        s_bwd_prop_dot_0(&_S1759, &_S1760, 0.0f);
        float3  _S1761 = _S1760.differential_0 + _S1759.differential_0 + raydir_29;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1762;
        (&_S1762)->primal_0 = _S1728;
        (&_S1762)->differential_0 = _S1708;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1763;
        (&_S1763)->primal_0 = _S1729;
        (&_S1763)->differential_0 = _S1708;
        s_bwd_prop_cross_0(&_S1762, &_S1763, _S1761);
        float3  s_diff_dy_T_8 = - _S1763.differential_0;
        float3  _S1764 = - s_diff_dy_T_8;
        float3  _S1765 = - _S1762.differential_0;
        FixedArray<float3 , 5>  _S1766;
        _S1766[int(0)] = _S1708;
        _S1766[int(1)] = _S1708;
        _S1766[int(2)] = _S1708;
        _S1766[int(3)] = _S1708;
        _S1766[int(4)] = _S1708;
        _S1766[int(2)] = _S1764;
        _S1766[int(3)] = s_diff_dy_T_8;
        _S1766[int(0)] = _S1765;
        _S1766[int(1)] = _S1762.differential_0;
        points_17[int(0)] = _S1766[int(0)];
        points_17[int(1)] = _S1766[int(1)];
        points_17[int(2)] = _S1766[int(2)];
        points_17[int(3)] = _S1766[int(3)];
        points_17[int(4)] = _S1766[int(4)];
        raydir_29 = _S1757;
    }
    else
    {
        points_17[int(0)] = _S1708;
        points_17[int(1)] = _S1708;
        points_17[int(2)] = _S1708;
        points_17[int(3)] = _S1708;
        points_17[int(4)] = _S1708;
        raydir_29 = _S1708;
    }
    float4  _S1767;
    if(_S1709)
    {
        if(_runFlag_31)
        {
            if(_runFlag_32)
            {
                if(_runFlag_33)
                {
                    FixedArray<float3 , 5>  _S1768 = points_17;
                    FixedArray<float3 , 5>  _S1769 = points_17;
                    FixedArray<float3 , 5>  _S1770 = points_17;
                    float3  _S1771 = _S1711 * points_17[int(3)];
                    float _S1772 = _S1771.x + _S1771.y + _S1771.z;
                    float4  _S1773 = _S1742;
                    *&((&_S1773)->w) = _S1772;
                    points_17[int(0)] = _S1708;
                    points_17[int(1)] = _S1708;
                    points_17[int(2)] = _S1708;
                    points_17[int(3)] = _S1708;
                    points_17[int(4)] = _S1708;
                    _S1711 = _S1770[int(2)];
                    normal_21 = _S1768[int(0)];
                    _S1726 = _S1769[int(1)];
                    _S1767 = _S1773;
                }
                else
                {
                    FixedArray<float3 , 5>  _S1774 = points_17;
                    FixedArray<float3 , 5>  _S1775 = points_17;
                    FixedArray<float3 , 5>  _S1776 = points_17;
                    FixedArray<float3 , 5>  _S1777 = points_17;
                    points_17[int(0)] = points_17[int(0)];
                    points_17[int(1)] = _S1774[int(1)];
                    points_17[int(2)] = _S1775[int(2)];
                    points_17[int(3)] = _S1776[int(3)];
                    points_17[int(4)] = _S1777[int(4)];
                    _S1711 = _S1708;
                    normal_21 = _S1708;
                    _S1726 = _S1708;
                    _S1767 = _S1742;
                }
                float3  _S1778 = _S1712 * (points_17[int(2)] + _S1711);
                float _S1779 = _S1778.x + _S1778.y + _S1778.z;
                float3  _S1780 = points_17[int(0)] + normal_21;
                float3  _S1781 = points_17[int(1)] + _S1726;
                float4  _S1782 = _S1742;
                *&((&_S1782)->z) = _S1779;
                float4  _S1783 = _S1767 + _S1782;
                points_17[int(0)] = _S1708;
                points_17[int(1)] = _S1708;
                points_17[int(2)] = _S1708;
                points_17[int(3)] = _S1708;
                points_17[int(4)] = _S1708;
                _S1711 = _S1781;
                _S1712 = _S1780;
                _S1767 = _S1783;
            }
            else
            {
                FixedArray<float3 , 5>  _S1784 = points_17;
                FixedArray<float3 , 5>  _S1785 = points_17;
                FixedArray<float3 , 5>  _S1786 = points_17;
                FixedArray<float3 , 5>  _S1787 = points_17;
                points_17[int(0)] = points_17[int(0)];
                points_17[int(1)] = _S1784[int(1)];
                points_17[int(2)] = _S1785[int(2)];
                points_17[int(3)] = _S1786[int(3)];
                points_17[int(4)] = _S1787[int(4)];
                _S1711 = _S1708;
                _S1712 = _S1708;
                _S1767 = _S1742;
            }
            float3  _S1788 = _S1713 * (points_17[int(1)] + _S1711);
            float _S1789 = _S1788.x + _S1788.y + _S1788.z;
            float3  _S1790 = points_17[int(0)] + _S1712;
            float4  _S1791 = _S1742;
            *&((&_S1791)->y) = _S1789;
            float4  _S1792 = _S1767 + _S1791;
            points_17[int(0)] = _S1708;
            points_17[int(1)] = _S1708;
            points_17[int(2)] = _S1708;
            points_17[int(3)] = _S1708;
            points_17[int(4)] = _S1708;
            _S1711 = _S1790;
            _S1767 = _S1792;
        }
        else
        {
            FixedArray<float3 , 5>  _S1793 = points_17;
            FixedArray<float3 , 5>  _S1794 = points_17;
            FixedArray<float3 , 5>  _S1795 = points_17;
            FixedArray<float3 , 5>  _S1796 = points_17;
            points_17[int(0)] = points_17[int(0)];
            points_17[int(1)] = _S1793[int(1)];
            points_17[int(2)] = _S1794[int(2)];
            points_17[int(3)] = _S1795[int(3)];
            points_17[int(4)] = _S1796[int(4)];
            _S1711 = _S1708;
            _S1767 = _S1742;
        }
        float3  _S1797 = _S1714 * (points_17[int(0)] + _S1711);
        float _S1798 = _S1797.x + _S1797.y + _S1797.z;
        float4  _S1799 = _S1742;
        *&((&_S1799)->x) = _S1798;
        _S1767 = _S1767 + _S1799;
    }
    else
    {
        _S1767 = _S1742;
    }
    *v_depths_7 = _S1767;
    *v_gt_normal_3 = raydir_29;
    return;
}

