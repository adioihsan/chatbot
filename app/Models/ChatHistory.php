<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class ChatHistory extends Model
{
    use HasUuids;

    // Fix for uuid PK
    protected $primaryKey = 'id';
    protected $keyType = 'string';
    protected $fillable = [
        'chat_id','prompt','response' 
    ];

    public function chat():BelongsTo{
        return $this->belongsTo(Chat::class,"chat_id","id");
    }

}
